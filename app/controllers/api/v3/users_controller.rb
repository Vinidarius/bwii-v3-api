class Api::V3::UsersController < Api::V3::BaseController

	def index
		@users = Api::V3::UsersFilter.new(User.all, params).collection
		render :json => array_serializer(@users, "classic")
	end

	def show
		@user = User.find_by_id(params[:id])
		return render :json => [] unless !@user.blank?
		render :json => @user.render_api
	end

	def list
		@users = Api::V3::UsersFilter.new(User.all, params).collection
		render :json => array_serializer(@users, "list")
	end

	def connect
		@user = User.find_by_id(params[:id])
		return render :json => [] unless !@user.blank?
		render :json => @user.render_connect_api
	end

	def details
		@user = User.find_by_id(params[:id])
		return render :json => [] unless !@user.blank?
		render :json => @user.render_details_api
	end

	def create
		@user = User.new(permitted_params)
		return render :json => [] unless @user.save
		render(
			json: @user.render_api,
			status: 201,
			location: api_v3_user_path(@user.id)
		)
	end

	def update
		@user = User.find_by_id(params[:id])
		return render :json => [] unless @user.update_attributes(permitted_params)
		render(
			json: @user.render_api,
			status: 201,
			location: api_v3_user_path(@user.id)
		)
	end

	def destroy
		@user = User.find(params[:id]);
		@user.archived = true;
		return render :json => [] unless @user.save
		render(
			json: @user.render_api,
			status: 201,
			location: api_v3_user_path(@user.id)
		)
	end

	private

	def permitted_params
		params.require(:user).permit(
			:old_id,
			:email,
			:firstname,
			:lastname,
			:phone_number,
			:company,
			:job,
			:cgus,
			:ccs,
			:comparution_text,
			:archived,
			:compagny_id
		)
	end

	def array_serializer users, route
		users_serialized = Array.new
		users.each do |user|
			case route
			when "classic"
					users_serialized.push(user.render_api)
				when "list"
					users_serialized.push(user.render_list_api)
			end
		end
		users_serialized
	end

end
