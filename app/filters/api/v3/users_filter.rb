require 'json'

class Api::V3::UsersFilter < Api::V3::BaseFilter

  def collection
    @users = self.resource
		# Agent.all.pluck(:compagny_id, :tokens).each do |el|
		# 	if params[:token].eql? el[1].keys.first
		# 		@compagny = el[0]
		# 	end
		# end

		# @compagny ? (@users = @users.where(compagny_id: @compagny)) : (return [])
		# @user_types = UserType.all.where(compagny_id: @compagny)
		@user_types = UserType.all

		if params[:cession].eql? "true"
			@users = @users.joins(:user_team_links, :visits).group('users.id', 'visits.id')
		end

		unless params[:archived].blank?
			@users = @users.where(archived: params[:archived])
		end

		unless params[:connectStatus].blank? || params[:connectStatus].length != 3
			@valid_users = []

			if params[:connectStatus][0] == "1"
				@valid_users = @users.where("users.current_sign_in_at > ?", DateTime.now.beginning_of_day - 7.days).pluck(:id).concat(@valid_users)
			end
			if params[:connectStatus][1] == "1"
				@valid_users = @users.where("users.current_sign_in_at < ? AND users.current_sign_in_at > ?", DateTime.now.beginning_of_day - 8.days, DateTime.now.beginning_of_day - 14.days).pluck(:id).concat(@valid_users)
			end
			if params[:connectStatus][2] == "1"
				@valid_users = @users.where("users.current_sign_in_at IS NULL OR users.current_sign_in_at < ?", DateTime.now.beginning_of_day - 15.days).pluck(:id).concat(@valid_users)
			end

			@users = @users.where(id: @valid_users)
		end

		if params[:name] && params[:name].length != 0
			@users = @users.where("firstname ILIKE '%#{params[:name]}%'").or(
								@users.where("lastname ILIKE '%#{params[:name]}%'")).or(
								@users.where("concat(firstname, ' ', lastname) ILIKE '%#{params[:name]}%'")).or(
								@users.where("concat(lastname, ' ', firstname) ILIKE '%#{params[:name]}%'")).or(
								@users.where("company ILIKE '%#{params[:name]}%'"))
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

		if params[:listOrder].eql? "0"
			@users = @users.order("lower(lastname) ASC")
		elsif params[:listOrder].eql? "1"
			@users = @users.order("lower(lastname) DESC")
		elsif params[:listOrder].eql? "2"
			@users = @users.joins(:visits).where(visits: {agent_id: params[:agent_id]}).order("visits.updated_at desc")
		end



		unless params[:area].blank?
			@valid_users = [];
			@valid_users = @users.joins(:needs).where("needs.area_min <= :area AND needs.area_max >= :area", {area: params[:area].to_i}).uniq.pluck(:id)
			@users = @users.where(id: @valid_users)
		end

		if params[:real_estate_categories] && params[:real_estate_categories].to_i != 0
			@real_estate_types = RealEstateType.all
			@value = params[:real_estate_categories].to_i
			@valid_users = []

			@real_estate_types.each_with_index do |el, index|
				# puts "value: " + @value.to_s
				# puts 2 ** (@real_estate_types.length - 1 - index)
				if @value >= 2 ** (@real_estate_types.length - 1 - index)
					@value -= 2 ** (@real_estate_types.length - 1 - index)
					# puts "element: " + el.name
					@valid_users = @users.joins(:real_estate_type_links).where(real_estate_type_links: {real_estate_type_id: el.id}).pluck(:id).concat(@valid_users)
				end
			end
			@users = @users.where(id: @valid_users)
		end

		if params[:sectors] && params[:sectors].size > 2
			@valid_users = []

			JSON.parse(params[:sectors]).each do |sector|
				@valid_users = @users.joins(:sector_links).where(sector_links: {sector_id: sector}).pluck(:id).concat(@valid_users)
			end
			@users = @users.where(id: @valid_users)
		end

		if params[:page] && params[:nbr]
			return self.with_associations(@users.page(params[:page]).per(params[:nbr]))
		end

   return self.with_associations(@users)
  end

end
