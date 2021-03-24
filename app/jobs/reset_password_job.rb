class ResetPasswordJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.all.each do |user|
			user.reset_password_token = 'temp'
			if (user.firstname && user.firstname[0])
				if (user.lastname && user.lastname[0])
					@password = user.lastname[0].upcase + user.lastname[0].upcase + "-2020-Bwii";
				else
					@password = user.lastname[0].upcase + "-2020-Bwii";
				end
			else
				@password = "2020-Bwii";
			end
			user.reset_password(@password, @password);
			user.save
		end
  end
end
