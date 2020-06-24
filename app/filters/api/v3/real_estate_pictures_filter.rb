class Api::V3::RealEstatePicturesFilter < Api::V3::BaseFilter

  def collection
    real_estate_pictures = self.resource

   return self.with_associations(real_estate_pictures)
  end

end
