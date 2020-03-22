class Api::V3::RoomsController < Api::V3::BaseController

	def index
		@rooms = Api::V3::RoomsFilter.new(Room.all, params).collection
		render :json => array_serializer(@rooms)
	end

	def show
		@room = Room.find_by_id(params[:id])
		return render :json => [] unless !@room.blank?
		render :json => @room.render_api
	end

	def create
		@room = Room.new(permitted_params)
		return render :json => [] unless @room.save
		render(
			json: @room.render_api,
			status: 201,
			location: api_v3_room_path(@room.id)
		)
	end

	def update
		@room = Room.find_by_id(params[:id])
		return render :json => [] unless @room.update_attributes(permitted_params)
		render(
			json: @room.render_api,
			status: 201,
			location: api_v3_room_path(@room.id)
		)
	end

	def destroy
		@room = Room.find(params[:id])
		return api_error(status: 422, errors: @room.errors) unless @room.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_room_path(@room.id)
		)
	end

	private

	def permitted_params
		params.require(:room).permit(
			:name,
			:area,
			:divisible,
			:terrace,
			:fill,
			:lot_id,
			:floor_id
		)
	end

	def array_serializer rooms
		rooms_serialized = Array.new
		rooms.each do |room|
			rooms_serialized.push(room.render_api)
		end
		rooms_serialized
	end

end
