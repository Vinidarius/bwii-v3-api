class Api::V3::ParkingsController < Api::V3::BaseController

	def index
		@parkings = Api::V3::ParkingsFilter.new(Parking.all, params).collection
		render :json => array_serializer(@parkings)
	end

	def show
		@parking = Parking.find_by_id(params[:id])
		return render :json => [] unless !@parking.blank?
		render :json => @parking.render_api
	end

	def create
		@parking = Parking.new(permitted_params)
		return render :json => [] unless @parking.save
		render(
			json: @parking.render_api,
			status: 201,
			location: api_v3_parking_path(@parking.id)
		)
	end

	def update
		@parking = Parking.find_by_id(params[:id])
		return render :json => [] unless @parking.update_attributes(permitted_params)
		render(
			json: @parking.render_api,
			status: 201,
			location: api_v3_parking_path(@parking.id)
		)
	end

	def destroy
		@parking = Parking.find(params[:id])
		return api_error(status: 422, errors: @parking.errors) unless @parking.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_parking_path(@parking.id)
		)
	end

	private

	def permitted_params
		params.require(:parking).permit(
			:real_estate_id,
			:places_number,
			:price,
			:nature,
			:sell_method,
		)
	end

	def array_serializer parkings
		parkings_serialized = Array.new
		parkings.each do |parking|
			parkings_serialized.push(parking.render_api)
		end
		parkings_serialized
	end

end
