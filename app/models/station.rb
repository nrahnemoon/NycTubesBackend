class Station < ActiveRecord::Base

	has_many :station_lines
	has_many :lines, :through => :station_lines
	has_many :station_edges, foreign_key: 'from_station_id'

end
