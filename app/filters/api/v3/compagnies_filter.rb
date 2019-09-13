class Api::V3::CompagniesFilter < Api::V3::BaseFilter

  def collection
    compagnies = self.resource

    unless params[:name].blank?
			compagnies = compagnies.select {|el| el["name"].upcase.include? params[:name].upcase }
    end

   return self.with_associations(compagnies)
  end

end
