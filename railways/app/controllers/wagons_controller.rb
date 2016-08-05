class WagonsController < ApplicationController
  before_action :set_wagon, only: [:show, :edit, :update, :destroy]

  def index
    @wagons = Wagon.all
  end

  def show
  end

  def new
    @wagon = Wagon.new
  end

  def edit
  end

  def create
    @wagon = Wagon.new(wagon_params)
    @wagon.save ? redirect_to(@wagon, notice: 'Wagon was successfully created.') : render(:new)
  end

  def update
    @wagon.update(wagon_params) ? redirect_to(@wagon, notice: 'Wagon was successfully updated.') : render(:edit)
  end

  def destroy
    @wagon.destroy
    redirect_to wagons_url, notice: 'Wagon was successfully destroyed.'
  end

  private
    def set_wagon
      @wagon = Wagon.find(params[:id])
    end

    def wagon_params
      params.require(:wagon).permit(:wagon_type, :train_id, :upper_places, :lower_places)
    end
end
