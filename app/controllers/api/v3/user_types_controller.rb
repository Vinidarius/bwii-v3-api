class Api::V3::UserTypesController < Api::V3::BaseController

	def index
		@user_types = Api::V3::UserTypesFilter.new(UserType.all, params).collection
		render :json => array_serializer(@user_types, "classic")
	end

	def show
		@user_type = UserType.find_by_id(params[:id])
		return render :json => [] unless !@user_type.blank?
		render :json => @user_type.render_api
	end

	def create
		@user_type = UserType.new(permitted_params)
		return render :json => [] unless @user_type.save
		render(
			json: @user_type.render_api,
			status: 201,
			location: api_v3_user_type_path(@user_type.id)
		)
	end

	def update
		@user_type = UserType.find_by_id(params[:id])
		return render :json => [] unless @user_type.update_attributes(permitted_params)
		render(
			json: @user_type.render_api,
			status: 201,
			location: api_v3_user_type_path(@user_type.id)
		)
	end

	def destroy
		@user_type = UserType.find(params[:id]);
		return api_error(status: 422, errors: @user_type.errors) unless @user_type.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_user_type_path(@user_type.id)
		)
	end

	private

	def permitted_params
		params.require(:user_type).permit(
			:name,
			:icon,
			:compagny_id
		)
	end

	def array_serializer user_types, route
		user_types_serialized = Array.new
		user_types.each do |user_type|
			case route
				when "classic"
					user_types_serialized.push(user_type.render_api)
				when "list"
					user_types_serialized.push(user_type.render_list_api)
			end
		end
		user_types_serialized
	end

end
