class Api::V3::RealEstatesController < Api::V3::BaseController

	def index
		@real_estates = Api::V3::RealEstatesFilter.new(RealEstate.all, params).collection
		render :json => array_serializer(@real_estates, "classic")
	end

	def show
		@real_estate = RealEstate.find_by_id(params[:id])
		return render :json => [] unless !@real_estate.blank?
		render :json => @real_estate.render_api
	end

	def list
		@real_estates = Api::V3::RealEstatesFilter.new(RealEstate.all, params).collection
		render :json => array_serializer(@real_estates, "list")
	end

	def details
		@real_estate = RealEstate.find_by_id(params[:id])
		return render :json => [] unless !@real_estate.blank?
		render :json => @real_estate.render_details_api
	end

	def duplicate
		@old_real_estate = RealEstate.find_by_id(params[:id])
		@new_real_estate = RealEstate.new(@old_real_estate.attributes)
		@new_real_estate.id = nil;
		return api_error(status: 422, errors: @new_real_estate.errors) unless @new_real_estate.save

		RealEstateTypeLink.where(real_estate_id: @old_real_estate.id).find_each do |old_real_estate_type_link|
			@new_real_estate_type_link = RealEstateTypeLink.new(old_real_estate_type_link.attributes)
			@new_real_estate_type_link.id = nil
			@new_real_estate_type_link.real_estate_id = @new_real_estate.id
			return api_error(status: 422, errors: @new_real_estate_type_link.errors) unless @new_real_estate_type_link.save
		end

		RealEstateSellTypeLink.where(real_estate_id: @old_real_estate.id).find_each do |old_real_estate_sell_type_link|
			@new_real_estate_sell_type_link = RealEstateSellTypeLink.new(old_real_estate_sell_type_link.attributes)
			@new_real_estate_sell_type_link.id = nil
			@new_real_estate_sell_type_link.real_estate_id = @new_real_estate.id
			return api_error(status: 422, errors: @new_real_estate_sell_type_link.errors) unless @new_real_estate_sell_type_link.save
		end

		RealEstateActorLink.where(real_estate_id: @old_real_estate.id).find_each do |old_real_estate_actor_link|
			@new_real_estate_actor_link = RealEstateActorLink.new(old_real_estate_actor_link.attributes)
			@new_real_estate_actor_link.id = nil
			@new_real_estate_actor_link.real_estate_id = @new_real_estate.id
			return api_error(status: 422, errors: @new_real_estate_actor_link.errors) unless @new_real_estate_actor_link.save
		end

		SectorLink.where(real_estate_id: @old_real_estate.id).find_each do |old_sector_link|
			@new_sector_link = SectorLink.new(old_sector_link.attributes)
			@new_sector_link.id = nil
			@new_sector_link.real_estate_id = @new_real_estate.id
			return api_error(status: 422, errors: @new_sector_link.errors) unless @new_sector_link.save
		end

		Building.where(real_estate_id: @old_real_estate.id).find_each do |old_building|
			@new_building = Building.new(old_building.attributes)
			@new_building.id = nil
			@new_building.real_estate_id = @new_real_estate.id
			return api_error(status: 422, errors: @new_building.errors) unless @new_building.save
			Floor.where(building_id: old_building.id).find_each do |old_floor|
				@new_floor = Floor.new(old_floor.attributes)
				@new_floor.id = nil
				@new_floor.building_id = @new_building.id
				return api_error(status: 422, errors: @new_floor.errors) unless @new_floor.save
				Room.where(floor_id: old_floor.id).find_each do |old_room|
					@new_room = Room.new(old_room.attributes)
					@new_room.id = nil
					@new_room.floor_id = @new_floor.id
					return api_error(status: 422, errors: @new_room.errors) unless @new_room.save
					RealEstateTypeLink.where(room_id: old_room.id).find_each do |old_real_estate_type_link|
						@new_real_estate_type_link = RealEstateTypeLink.new(old_real_estate_type_link.attributes)
						@new_real_estate_type_link.id = nil
						@new_real_estate_type_link.room_id = @new_room.id
						return api_error(status: 422, errors: @new_real_estate_type_link.errors) unless @new_real_estate_type_link.save
					end
				end
			end
		end

		Parking.where(real_estate_id: @old_real_estate.id).find_each do |old_parking|
			@new_parking = Parking.new(old_parking.attributes)
			@new_parking.id = nil
			@new_parking.real_estate_id = @new_real_estate.id
			return api_error(status: 422, errors: @new_parking.errors) unless @new_parking.save
		end

		RealEstatePicture.where(real_estate_id: @old_real_estate.id).find_each do |old_real_estate_picture|
			@request = Cloudinary::Uploader.upload(old_real_estate_picture.url)
			@new_real_estate_picture = RealEstatePicture.new(old_real_estate_picture.attributes)
			@new_real_estate_picture.id = nil
			@new_real_estate_picture.real_estate_id = @new_real_estate.id
			@new_real_estate_picture.public_id = @request["public_id"]
			@new_real_estate_picture.url = @request["secure_url"]
			@new_real_estate_picture.url = @new_real_estate_picture.url[0, @new_real_estate_picture.url.index('upload') + "upload".size] + "/a_" + params[:angle].to_s + @new_real_estate_picture.url[(@new_real_estate_picture.url.index('upload') + "upload".size)..@new_real_estate_picture.url.size]
			return api_error(status: 422, errors: @new_real_estate_picture.errors) unless @new_real_estate_picture.save
		end

		Plan.where(real_estate_id: @old_real_estate.id).find_each do |old_plan|
			@request = Cloudinary::Uploader.upload(old_plan.url)
			@new_plan = Plan.new(old_plan.attributes)
			@new_plan.id = nil
			@new_plan.real_estate_id = @new_real_estate.id
			@new_plan.public_id = @request["public_id"]
			@new_plan.url = @request["secure_url"]
			@new_plan.url = @new_plan.url[0, @new_plan.url.index('upload') + "upload".size] + "/a_" + params[:angle].to_s + @new_plan.url[(@new_plan.url.index('upload') + "upload".size)..@new_plan.url.size]
			return api_error(status: 422, errors: @new_plan.errors) unless @new_plan.save
		end

		render(
			json: @new_real_estate.render_list_api,
			status: 201,
			location: api_v3_real_estate_path(@new_real_estate.id)
		)
	end

	def all
		@real_estates = RealEstate.all
		render :json => array_serializer(@real_estates, "classic")
	end

	def create
		@real_estate = RealEstate.new(permitted_params)
		return render :json => [] unless @real_estate.save
		render(
			json: @real_estate.render_api,
			status: 201,
			location: api_v3_real_estate_path(@real_estate.id)
		)
	end

	def update
		@real_estate = RealEstate.find_by_id(params[:id])
		return render :json => [] unless @real_estate.update_attributes(permitted_params)
		render(
			json: @real_estate.render_api,
			status: 201,
			location: api_v3_real_estate_path(@real_estate.id)
		)
	end

	def destroy
		@real_estate = RealEstate.find(params[:id]);
		@real_estate.archived = true;
		return render :json => [] unless @real_estate.save
		render(
			json: @real_estate.render_api,
			status: 201,
			location: api_v3_real_estate_path(@real_estate.id)
		)
	end

	private

	def permitted_params
		params.require(:real_estate).permit(
			:old_id,
			:title,
			:address,
			:city,
			:zipcode,
			:longitude,
			:latitude,
			:description,
			:years,
			:dispo,
			:area,
			:divisible,
			:charges,
			:foncier,
			:archived,
			:publy,
			:verified,
			:compagny_id
		)
	end

	def array_serializer real_estates, route
		real_estates_serialized = Array.new
		real_estates.each do |real_estate|
			case route
			when "classic"
					real_estates_serialized.push(real_estate.render_api)
				when "list"
					real_estates_serialized.push(real_estate.render_list_api)
			end
		end
		real_estates_serialized
	end

end
