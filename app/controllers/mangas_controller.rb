require 'net/http'

class MangasController < ApplicationController
  before_action :set_manga, only: %i[ show edit update destroy refresh ]

  def index
    @mangas = Manga.all
  end

  def show
  end

  def new
    @manga = Manga.new
  end

  def create
    @manga = Manga.new(manga_params)

    if @manga.source_instance.crawl
      redirect_to manga_url(@manga), notice: "Manga was successfully created."
    else
      redirect_to new_manga_path, notice: "Could not create manga."
    end
  end

  def destroy
    @manga.destroy

    redirect_to mangas_url, notice: "Manga was successfully destroyed."
  end

  def refresh
    if @manga.source_instance.refresh
      Notifiers::DiscordNotifier.new(manga: @manga).notify
    end
    redirect_back(fallback_location: root_path)
  end

  def refresh_all
    # TODO: Set off a job in background
    Manga.all.each do |manga|
      if manga.source_instance.refresh
        Notifiers::DiscordNotifier.new(manga: @manga).notify
      end
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_manga
    @manga = Manga.find(params[:id])
  end

  def manga_params
    params.require(:manga).permit(:external_id, :source)
  end
end
