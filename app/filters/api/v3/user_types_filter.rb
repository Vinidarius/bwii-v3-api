class Api::V3::UserTypesFilter < Api::V3::BaseFilter

  def collection
    @user_types = self.resource
		Agent.all.pluck(:compagny_id, :tokens).each do |el|
			if params[:token].eql? el[1].keys.first
				@compagny = el[0]
			end
		end

		@compagny ? (@user_types = @user_types.where(compagny_id: @compagny)) : (return [])

   return self.with_associations(@user_types)
  end

end
