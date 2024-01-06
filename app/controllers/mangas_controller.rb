require 'net/http'

class MangasController < ApplicationController
  before_action :set_manga, only: %i[ show edit update destroy refresh image ]

  skip_before_action :authenticate_user!, only: %i[ image ]

  def index
    @mangas = Manga.order(last_refreshed: :desc)
  end

  def show
  end

  def new
    @manga = Manga.new
  end

  def edit
  end

  def create
    @manga = Manga.new(manga_params)

    if @manga.source_instance.crawl
      redirect_to manga_url(@manga), notice: "Manga was successfully created."
    else
      redirect_to new_manga_path, notice: "Could not create manga."
    end
  end

  def update
    if @manga.update(manga_params)
      @manga.source_instance.crawl
      redirect_to manga_path(@manga), notice: "Manga was successfully updated."
    else
      redirect_to edit_manga_path(@manga), notice: "Could not update manga."
    end
  end

  def destroy
    @manga.destroy

    redirect_to mangas_url, notice: "Manga was successfully destroyed."
  end

  def refresh
    Rails.logger.info("C_HOST: #{Rails.application.routes.default_url_options[:host]}")
    Rails.logger.info("C_PROTOCOL: #{Rails.application.routes.default_url_options[:protocol]}")
    @manga.refresh
    redirect_back(fallback_location: root_path)
  end

  def refresh_all
    # TODO: Set off a job in background
    Manga.all.each do |manga|
      manga.refresh
    end
    redirect_back(fallback_location: root_path)
  end

  def image
    uri = URI(@manga.image)
    response = Net::HTTP.get_response(uri, @manga.source_instance.image_headers)

    if response.is_a? Net::HTTPSuccess
      send_data response.body, type: response["Content-Type"], disposition: "inline"
    else
      render plain: "Image not found", status: 404
    end
  end

  private

  def set_manga
    @manga = Manga.find(params[:id])
  end

  def manga_params
    params.require(:manga).permit(:external_id, :source, :active, notifier_ids: [])
  end
end
