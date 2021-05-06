class SetDivisibleJob < ApplicationJob
  queue_as :default

  def perform(*args)
		RealEstate.all.each do |real_estate|
			@min_val = 0;
			real_estate.buildings.each do |building|
				if building.divisible && building.divisible.to_i != 0 && (@min_val == 0 || building.divisible.to_i < @min_val)
					@min_val = building.divisible.to_i
				end
			end
			if @min_val > 0
				real_estate.divisible = @min_val
				real_estate.save
			end
    end
  end
end
