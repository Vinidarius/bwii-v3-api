class Api::V3::RealEstateActorLinksController < Api::V3::BaseController

	def index
		@real_estate_actor_links = Api::V3::RealEstateActorLinksFilter.new(RealEstateActorLink.all, params).collection
		render :json => array_serializer(@real_estate_actor_links)
	end

	def show
		@real_estate_actor_link = RealEstateActorLink.find_by_id(params[:id])
		return render :json => [] unless !@real_estate_actor_link.blank?
		render :json => @real_estate_actor_link.render_api
	end

	def create
		if RealEstateActorLink.exists?(real_estate_id: params[:real_estate_id], real_estate_actor_id: params[:real_estate_actor_id])
			params[:id] = RealEstateActorLink.find_by(real_estate_id: params[:real_estate_id], real_estate_actor_id: params[:real_estate_actor_id]).id
			self.update();
		else
			@real_estate_actor_link = RealEstateActorLink.new(permitted_params)
			return render :json => [] unless @real_estate_actor_link.save
			render(
				json: @real_estate_actor_link.render_api,
				status: 201,
				location: api_v3_real_estate_actor_link_path(@real_estate_actor_link.id)
			)
		end
	end

	def update
		@real_estate_actor_link = RealEstateActorLink.find_by_id(params[:id])
		return render :json => [] unless @real_estate_actor_link.update_attributes(permitted_params)
		render(
			json: @real_estate_actor_link.render_api,
			status: 201,
			location: api_v3_real_estate_actor_link_path(@real_estate_actor_link.id)
		)
	end

	def destroy
		@real_estate_actor_link = RealEstateActorLink.find(params[:id]);
		return render :json => [] unless @real_estate_actor_link.destroy
		render(
			json: {},
			status: 201,
			location: api_v3_real_estate_actor_link_path(@real_estate_actor_link.id)
		)
	end

	private

	def permitted_params
		params.require(:real_estate_actor_link).permit(
			:real_estate_actor_id,
			:real_estate_id,
			:user_id,
		)
	end

	def array_serializer real_estate_actor_links
		real_estate_actor_links_serialized = Array.new
		real_estate_actor_links.each do |real_estate_actor_link|
			real_estate_actor_links_serialized.push(real_estate_actor_link.render_api)
		end
		real_estate_actor_links_serialized
	end

end
