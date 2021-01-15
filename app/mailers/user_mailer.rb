class UserMailer < Devise::Mailer

	def reset_password(user)
		mail(
			from: "support@b-wii.fr",
			to: user.email,
			subject: "Changement de mot de passe BWII",
			delivery_method_options: { api_key: '59795337f073950857377d3604a60493', secret_key: '8e5f3fd672ea238347aaa6582e1ea7d2', version: "v3.1" }
		)
	end

end
