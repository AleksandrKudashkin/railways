class TrainsController < ApplicationController
  before_action :set_train, only: [:show, :edit, :update, :destroy]

  def index
    @trains = Train.all
  end

  def show
    #@economy_wagons = @train.wagons.where(wagon_type: 'economy')
    #@first_class_wagons = @train.wagons.where(wagon_type: 'first')
  end

  def new
    @train = Train.new
  end

  def edit
  end

  def create
    @train = Train.new(train_params)
    @train.save ? redirect_to(@train, notice: 'Train was successfully created.') : render(:new)
  end

  def update
    @train.update(train_params) ? redirect_to(@train, notice: 'Train was successfully updated.') : render(:edit)
  end

  def destroy
    @train.destroy
    redirect_to trains_url, notice: 'Train was successfully destroyed.'
  end

  private
    def set_train
      @train = Train.find(params[:id])
    end

    def train_params
      params.require(:train).permit(:number, :current_station_id, :route_id)
    end
end
