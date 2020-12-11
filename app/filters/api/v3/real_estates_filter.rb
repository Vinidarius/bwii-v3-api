class Api::V3::RealEstatesFilter < Api::V3::BaseFilter

  def collection
    @real_estates = self.resource
		# Agent.all.pluck(:compagny_id, :tokens).each do |el|
		# 	if params[:token].eql? el[1].keys.first
		# 		@compagny = el[0]
		# 	end
		# end

		# @compagny ? (@real_estates = @real_estates.where(compagny_id: @compagny)) : (return [])
		# @real_estate_types = RealEstateType.all.where(compagny_id: @compagny)
		@real_estate_types = RealEstateType.all

		unless params[:archived].blank?
			@real_estates = @real_estates.where(archived: params[:archived])
		end

		if params[:title] && params[:title].length != 0
			@valid_real_estates = []

			@valid_real_estates = @real_estates.where("title ILIKE '%#{params[:title]}%'").pluck(:id)
			@real_estates = @real_estates.where(id: @valid_real_estates);
		end

		if params[:categories] && params[:categories].to_i != 0
			@value = params[:categories].to_i
			@valid_real_estates = []

			if params[:operand].eql? "true"
				@real_estate_types.each_with_index do |el, index|
					if @value >= 2 ** (@real_estate_types.length - 1 - index)
						@value -= 2 ** (@real_estate_types.length - 1 - index)
						@valid_real_estates = @real_estates.joins(:real_estate_type_links).where(real_estate_type_links: {real_estate_type_id: el.id}).pluck(:id)
						@real_estates = @real_estates.where(id: @valid_real_estates)
					end
				end
			else
				@real_estate_types.each_with_index do |el, index|
					if @value >= 2 ** (@real_estate_types.length - 1 - index)
						@value -= 2 ** (@real_estate_types.length - 1 - index)
						@valid_real_estates = @real_estates.joins(:real_estate_type_links).where(real_estate_type_links: {real_estate_type_id: el.id}).pluck(:id).concat(@valid_real_estates)
					end
				end
				@real_estates = @real_estates.where(id: @valid_real_estates)
			end
		end

		if params[:sectors] && params[:sectors].size > 2
			@valid_real_estates = [];

			JSON.parse(params[:sectors]).each do |sector|
				@valid_real_estates = @real_estates.joins(:sector_links).where(sector_links: {sector_id: sector}).pluck(:id).concat(@valid_real_estates)
			end
			@real_estates = @real_estates.where(id: @valid_real_estates)
		end

		if params[:minSize].to_i.zero? || params[:maxSize].to_i.zero?
			@real_estates = @real_estates.where(area: ("0".to_i)..("100000".to_i))
		else
			@real_estates = @real_estates.where(area: (params[:minSize].to_i)..(params[:maxSize].to_i))
		end

		if params[:alphaOrder].eql? "true"
			@real_estates = @real_estates.order("lower(title) ASC")
		else
			@real_estates = @real_estates.order("lower(title) DESC")
		end

		if params[:page] && params[:nbr]
			return self.with_associations(@real_estates.page(params[:page]).per(params[:nbr]))
		end

		# filter by sector, title, proprio, agents, promoteur

   return self.with_associations(@real_estates)
  end

end
