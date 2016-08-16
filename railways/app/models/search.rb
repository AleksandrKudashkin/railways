class Search
  include ActiveModel::Validations

  validate :diff_stations, on: :new

  def diff_stations
    errors.add(:station_depart, "stations must be different") if params[:station_depart] == params[:station_arrival]
  end
end
