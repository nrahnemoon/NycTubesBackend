class StationEdge < ActiveRecord::Base

	belongs_to :from_station, class_name: 'Station', foreign_key: 'from_station_id'
	belongs_to :to_station, class_name: 'Station', foreign_key: 'to_station_id'

end
