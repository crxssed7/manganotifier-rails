class NotifiersController < ApplicationController
  before_action :set_notifier, only: %i[ show edit update destroy ]

  def index
    @notifiers = Notifier.all
  end

  def show
  end

  def new
    @notifier = Notifier.new
  end

  def edit
  end

  def create
    @notifier = Notifier.new(notifier_params)

    if @notifier.save
      redirect_to notifier_url(@notifier), notice: "Notifier was successfully created."
    else
      redirect_to new_notifier_path, notice: "Could not create notifier."
    end
  end

  def update
    if @notifier.update(notifier_params)
      redirect_to notifier_url(@notifier), notice: "Notifier was successfully updated."
    else
      redirect_to edit_notifier_path(@notifier), notice: "Could not update notifier."
    end
  end

  def destroy
    @notifier.destroy

    redirect_to notifiers_url, notice: "Notifier was successfully destroyed."
  end

  private

  def set_notifier
    @notifier = Notifier.find(params[:id])
  end

  def notifier_params
    params.require(:notifier).permit(:name, :webhook_url, :notifier_type)
  end
end
