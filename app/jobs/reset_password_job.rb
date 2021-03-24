class ResetPasswordJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.all.each do |user|
			user.reset_password_token = 'temp'
			@password = user.lastname[0].upcase + user.lastname[0].upcase + "-2020-Bwii";
			user.reset_password(@password, @password);
			user.save
		end
  end
end
