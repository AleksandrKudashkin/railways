class Admin::TrainsController < Admin::BaseController
  before_action :set_train, only: [:show, :edit, :update, :destroy, :update_sorting]

  def index
    @trains = Train.all
  end

  def show
    if @train.sorted_from_head
      @coaches = @train.coaches.order(counting_number: :asc)
    else
      @coaches = @train.coaches.order(counting_number: :desc)
    end  
  end

  def new
    @train = Train.new
  end

  def edit
  end

  def create
    @train = Train.new(train_params)
    @train.save ? redirect_to([:admin, @train], notice: 'Train was successfully created.') : render(:new)
  end

  def update
    @train.update(train_params) ? redirect_to([:admin, :trains], notice: 'Train was successfully updated.') : render(:edit)
  end

  def destroy
    @train.destroy
    redirect_to [:admin, :trains], notice: 'Train was successfully destroyed.'
  end

  def update_sorting
    @train.sorted_from_head = params[:sorted_from_head]
    @train.save
    redirect_to [:admin, @train]
  end

  private
    def set_train
      @train = Train.find(params[:id])
    end

    def train_params
      params.require(:train).permit(:number, :current_station_id, :route_id)
    end
end
