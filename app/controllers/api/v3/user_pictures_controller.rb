class UserPicturesController < ApplicationController

	def index
		@user_pictures = Api::V3::UserPicturesFilter.new(UserPicture.all, params).collection
		render :json => array_serializer(@user_pictures)
	end

	def show
		@user_picture = UserPicture.find_by_id(params[:id])
		return render :json => [] unless !@user_picture.blank?
		render :json => @user_picture.render_api
	end

	def create
		@request = Cloudinary::Uploader.upload(params[:base])
		@user_picture = UserPicture.new(permitted_params)
		@user_picture.public_id = @request["public_id"]
		@user_picture.url = @request["secure_url"]
		@user_picture.url = @user_picture.url[0, @user_picture.url.index('upload') + "upload".size] + "/a_" + params[:angle].to_s + @user_picture.url[(@user_picture.url.index('upload') + "upload".size)..@user_picture.url.size]
		return render :json => [] unless @user_picture.save
		render(
			json: @user_picture.render_api,
			status: 201,
			location: api_v3_user_picture_path(@user_picture.id)
		)
	end

	def update
		@user_picture = UserPicture.find_by_id(params[:id])
		@user_picture.url = @user_picture.url[0, @user_picture.url.index('/a_') + "/a_".size] + params[:angle].to_s + @user_picture.url[(@user_picture.url.index('/a_') + @user_picture.url.split('/')[6].size + 1)..@user_picture.url.size]
		return render :json => [] unless @user_picture.update_attributes(permitted_params)
		render(
			json: @user_picture.render_api,
			status: 201,
			location: api_v3_user_picture_path(@user_picture.id)
		)
	end

	def destroy
		@user_picture = UserPicture.find(params[:id])
		Cloudinary::Uploader.destroy(@user_picture.public_id)
		return api_error(status: 422, errors: @user_picture.errors) unless @user_picture.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_user_picture_path(@user_picture.id)
		)
	end

	private

	def permitted_params
		params.require(:user_picture).permit(
			:public_id,
			:url,
			:position,
			:angle,
			:user_id
		)
	end

	def array_serializer user_pictures
		user_pictures_serialized = Array.new
		user_pictures.each do |user_picture|
			user_pictures_serialized.push(user_picture.render_api)
		end
		user_pictures_serialized
	end

end
