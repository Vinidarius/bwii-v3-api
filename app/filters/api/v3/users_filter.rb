class Api::V3::UsersFilter < Api::V3::BaseFilter

  def collection
    @users = self.resource
		Agent.all.pluck(:compagny_id, :tokens).each do |el|
			if params[:token].eql? el[1].keys.first
				@compagny = el[0]
			end
		end

		@compagny ? (@users = @users.where(compagny_id: @compagny)) : (return [])
		@user_types = UserType.all.where(compagny_id: @compagny)

		unless params[:archived].blank?
			@users = @users.where(archived: params[:archived])
		end

		unless params[:connectStatus].blank? || params[:connectStatus].length != 3
			@valid_users = []

			if params[:connectStatus][0] == "1"
				@valid_users = @users.where("users.current_sign_in_at IS NULL OR users.current_sign_in_at < ?", DateTime.now.beginning_of_day - 15.days).pluck(:id).concat(@valid_users)
			end
			if params[:connectStatus][1] == "1"
				@valid_users = @users.where("users.current_sign_in_at < ? AND users.current_sign_in_at > ?", DateTime.now.beginning_of_day - 8.days, DateTime.now.beginning_of_day - 14.days).pluck(:id).concat(@valid_users)
			end
			if params[:connectStatus][2] == "1"
				@valid_users = @users.where("users.current_sign_in_at > ?", DateTime.now.beginning_of_day - 7.days).pluck(:id).concat(@valid_users)
			end

			@users = @users.where(id: @valid_users)
		end

		if params[:categories] && params[:categories].to_i != 0
			@value = params[:categories].to_i
			@valid_users = []

			if params[:operand].eql? "true"
				@user_types.each_with_index do |el, index|
					if @value >= 2 ** (@user_types.length - 1 - index)
						@value -= 2 ** (@user_types.length - 1 - index)
						@valid_users = @users.joins(:user_type_links).where(user_type_links: {user_type_id: el.id}).pluck(:id)
						@users = @users.where(id: @valid_users)
					end
				end
			else
				@user_types.each_with_index do |el, index|
					if @value >= 2 ** (@user_types.length - 1 - index)
						@value -= 2 ** (@user_types.length - 1 - index)
						@valid_users = @users.joins(:user_type_links).where(user_type_links: {user_type_id: el.id}).pluck(:id).concat(@valid_users)
					end
				end
				@users = @users.where(id: @valid_users)
			end
		end

		if params[:alphaOrder].eql? "true"
			@users = @users.order("lower(lastname) ASC")
		else
			@users = @users.order("lower(lastname) DESC")
		end

		if params[:page] && params[:nbr]
			return self.with_associations(@users.page(params[:page]).per(params[:nbr]))
		end

   return self.with_associations(@users)
  end

end
