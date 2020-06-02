class Api::V3::RealEstateActorsFilter < Api::V3::BaseFilter

  def collection
    real_estate_actors = self.resource

   return self.with_associations(real_estate_actors)
  end

end
