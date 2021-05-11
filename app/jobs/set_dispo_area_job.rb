class SetDispoAreaJob < ApplicationJob
  queue_as :default

	def perform(*args)
		RealEstate.limit(100).each do |real_estate|
			@dispo_area = 0;
			real_estate.buildings.each do |building|
				building.floors.each do |floor|
					floor.rooms.each do |room|
						if !room.fill
							@dispo_area += room.area.to_i
						end
					end
				end
			end
			real_estate.dispo_area = @dispo_area
			real_estate.save
  	end
	end

end
