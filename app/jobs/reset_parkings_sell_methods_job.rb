class ResetParkingsSellMethodsJob < ApplicationJob
  queue_as :default

  def perform(*args)
		Parking.all.each do |parking|
			if parking.sell_method.eql? 4
				parking.update_attributes(sell_method: 0)
			elsif parking.sell_method.eql? 0
				parking.sell_method = 1
			elsif parking.sell_method.eql? 1
				parking.sell_method = 2
			elsif parking.sell_method.eql? 2
				parking.sell_method = 4
			elsif parking.sell_method.eql? 3
				parking.sell_method = 8
			end
			parking.save
		end
  end

end
