class Api::V3::RegionsFilter < Api::V3::BaseFilter

  def collection
    regions = self.resource

   return self.with_associations(regions)
  end

end
