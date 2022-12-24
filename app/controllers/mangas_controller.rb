require 'net/http'

class MangasController < ApplicationController
  before_action :set_manga, only: %i[ show edit update destroy ]

  # GET /mangas or /mangas.json
  def index
    @mangas = Manga.all
  end

  # GET /mangas/1 or /mangas/1.json
  def show
  end

  # GET /mangas/new
  def new
    @manga = Manga.new
  end

  # POST /mangas or /mangas.json
  def create
    @manga = Manga.new(manga_params)

    source = Sources::Mangapill.new(manga: @manga)

    if source.crawl
      redirect_to manga_url(@manga), notice: "Manga was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /mangas/1 or /mangas/1.json
  def destroy
    @manga.destroy

    redirect_to mangas_url, notice: "Manga was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manga
      @manga = Manga.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def manga_params
      params.require(:manga).permit(:external_id)
    end
end
