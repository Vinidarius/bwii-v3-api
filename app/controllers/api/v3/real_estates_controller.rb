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

		render(
			json: @new_real_estate.render_api,
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
