require 'csv'

Line.destroy_all
ShortestPath.destroy_all
StationEdge.destroy_all
StationLine.destroy_all
Station.destroy_all

stationsCSVText = File.read(Rails.root.join('lib', 'assets', 'stations.csv'))

stationsCSV = CSV.new(stationsCSVText)

stationsCSV.to_a[1..-1].each do |stationRow|

	line = Line.find_by(:id => stationRow[2].to_i)
	if !line
		line = Line.create(:id => stationRow[2].to_i, :name => stationRow[1])
	end

	station = Station.find_by(:lattitude => stationRow[4].to_f, :longitude => stationRow[5].to_f)
	if !station
		station = Station.create(
			:id => stationRow[6].to_i,
			:name => stationRow[0],
			:lattitude => stationRow[4].to_f,
			:longitude => stationRow[5].to_f)
	end

	StationLine.create(
		:station_id => station.id,
		:line_id => line.id,
		:station_number => stationRow[3].to_i)

end

Station.all.each { |station|
	station.station_lines.each { |station_line|

		station_number = station_line.station_number
		previous_station_line = StationLine.find_by(
			:line_id => station_line.line_id,
			:station_number => (station_number - 1))
		next_station_line = StationLine.find_by(
			:line_id => station_line.line_id,
			:station_number => (station_number + 1))

		if !!previous_station_line
			previous_station = previous_station_line.station
			distance_to_previous = Geocoder::Calculations.distance_between(
				[station.lattitude, station.longitude],
				[previous_station.lattitude, previous_station.longitude])
			StationEdge.create(
				:distance => distance_to_previous,
				:from_station_id => station.id,
				:to_station_id => previous_station.id)
		end

		if !!next_station_line
			next_station = next_station_line.station
			distance_to_next = Geocoder::Calculations.distance_between(
				[station.lattitude, station.longitude],
				[next_station.lattitude, next_station.longitude])
			StationEdge.create(
				:distance => distance_to_next,
				:from_station_id => station.id,
				:to_station_id => next_station.id)
		end
	}
}

graph = []

Station.all.each { |station|
	station.station_edges.each { |station_edge|
		graphArr = []
		graphArr.push(station_edge.from_station_id)
		graphArr.push(station_edge.to_station_id)
		graphArr.push(station_edge.distance.to_f)
		graph.push(graphArr)
	}
}

Station.all.each { |from_station|
	Station.all.each { |to_station|
		exists = ShortestPath.exists?(:from_station_id => from_station.id, :to_station_id => to_station.id)
		if from_station.id != to_station.id && !exists

			ob = Dijkstra.new(from_station.id, to_station.id, graph)

			ShortestPath.create(
				:path => ob.shortest_path.to_s,
				:from_station_id => from_station.id,
				:to_station_id => to_station.id,
				:distance => ob.cost)

		end
	}
}
