class SearchesController < ApplicationController
  def show
  end

  def new
    if params[:station_depart] == params[:station_arrive]
      @error = "Stations must be different" 
      render 'show'
    end
    @start_st = RailwayStation.find(params[:station_depart])
    @end_st = RailwayStation.find(params[:station_arrive])
    @trains = Train.joins(route: :railway_stations).where('railway_stations.id IN (?)', [@start_st, @end_st]).uniq
  end
end
