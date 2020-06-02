class Api::V3::RealEstateActorLinksFilter < Api::V3::BaseFilter

  def collection
    real_estate_actor_links = self.resource

		unless params[:actor_id].blank?
			real_estate_actor_links = real_estate_actor_links.where(real_estate_actor_id: params[:actor_id])
		end

		unless params[:real_estate_id].blank?
			real_estate_actor_links = real_estate_actor_links.where(real_estate_id: params[:real_estate_id])
		end

		unless params[:user_id].blank?
			real_estate_actor_links = real_estate_actor_links.where(user_id: params[:user_id])
		end

   return self.with_associations(real_estate_actor_links)
  end

end
