class Admin::RailwayStationsController < Admin::BaseController
  before_action :set_railway_station, except: [:index, :new, :create]
  before_action :set_route, only: [:update_time_position]

  def index
    @railway_stations = RailwayStation.all
  end

  def show
  end

  def new
    @railway_station = RailwayStation.new
  end

  def edit
  end

  def create
    @railway_station = RailwayStation.new(railway_station_params)
    @railway_station.save ? redirect_to([:admin, @railway_station], notice: 'Railway station was successfully created.') : render(:new)
  end

  def update
    if @railway_station.update(railway_station_params) 
      redirect_to [:admin, :railway_stations], notice: 'Railway station was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @railway_station.destroy
    redirect_to [:admin, :railway_stations], notice: 'Railway station was successfully destroyed.'
  end

  def update_time_position
    @railway_station.update_special(@route, params)
    redirect_to [:admin, @route]
  end

  private
    def set_route
      @route = Route.find(params[:route_id])
    end
    
    def set_railway_station
      @railway_station = RailwayStation.find(params[:id])
    end

    def railway_station_params
      params.require(:railway_station).permit(:title)
    end
end
