class Api::V3::RealEstatePicturesController < Api::V3::BaseController

	def index
		@real_estate_pictures = Api::V3::RealEstatePicturesFilter.new(RealEstatePicture.all, params).collection
		render :json => array_serializer(@real_estate_pictures)
	end

	def show
		@real_estate_picture = RealEstatePicture.find_by_id(params[:id])
		return render :json => [] unless !@real_estate_picture.blank?
		render :json => @real_estate_picture.render_api
	end

	def create
		@request = Cloudinary::Uploader.upload(params[:base])
		@real_estate_picture = RealEstatePicture.new(permitted_params)
		@real_estate_picture.public_id = @request["public_id"]
		@real_estate_picture.url = @request["secure_url"]
		return render :json => [] unless @real_estate_picture.save
		render(
			json: @real_estate_picture.render_api,
			status: 201,
			location: api_v3_real_estate_picture_path(@real_estate_picture.id)
		)
	end

	def update
		@real_estate_picture = RealEstatePicture.find_by_id(params[:id])
		return render :json => [] unless @real_estate_picture.update_attributes(permitted_params)
		render(
			json: @real_estate_picture.render_api,
			status: 201,
			location: api_v3_real_estate_picture_path(@real_estate_picture.id)
		)
	end

	def destroy
		@real_estate_picture = RealEstatePicture.find(params[:id])
		Cloudinary::Uploader.destroy(@real_estate_picture.public_id)
		return api_error(status: 422, errors: @real_estate_picture.errors) unless @real_estate_picture.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_real_estate_picture_path(@real_estate_picture.id)
		)
	end

	private

	def permitted_params
		params.require(:real_estate_picture).permit(
			:public_id,
			:url,
			:position,
			:angle,
			:real_estate_id
		)
	end

	def array_serializer real_estate_pictures
		real_estate_pictures_serialized = Array.new
		real_estate_pictures.each do |real_estate_picture|
			real_estate_pictures_serialized.push(real_estate_picture.render_api)
		end
		real_estate_pictures_serialized
	end

end
