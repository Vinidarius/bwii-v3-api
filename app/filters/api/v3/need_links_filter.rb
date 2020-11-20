class Api::V3::NeedLinksFilter < Api::V3::BaseFilter

  def collection
    @need_links = self.resource

		unless params[:user_id].blank?
			@need_links = @need_links.where(need_id: nil)
			@need_links = @need_links.where('need_links.user_id = ?', params[:user_id])
		end

   return self.with_associations(@need_links.uniq)
  end

	def need_links

		@needs = Need.where(id: self.resource.pluck(:need_id))

		if params[:real_estate_id]
			@real_estate = RealEstate.find_by(id: params[:real_estate_id])

			@needs = @needs.where("needs.area_min <= :area AND needs.area_max >= :area", {area: @real_estate.area})

			@valid_needs = [];
			@real_estate.real_estate_type_links.each do |real_estate_type|
				@valid_needs = @needs.joins(:real_estate_type_links).where(real_estate_type_links: {real_estate_type_id: real_estate_type.real_estate_type_id}).pluck(:id)
				@needs = @needs.where(id: @valid_needs)
			end

			@valid_need = [];
			@real_estate.sector_links.each do |real_estate_sector|
				@valid_needs = @needs.joins(:sector_links).where(sector_links: {sector_id: real_estate_sector.sector_id}).pluck(:id)
				@needs = @needs.where(id: @valid_needs)
			end
		end

		return self.with_associations(@needs.ids)

	end

end
