class Search
  include ActiveModel::Validations

  validate :diff_stations, on: :new

  def diff_stations
    if params[:station_depart] == params[:station_arrival]
      errors.add(:station_depart, "stations must be different")
    end
  end
end
