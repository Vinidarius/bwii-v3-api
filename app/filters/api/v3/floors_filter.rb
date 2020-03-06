class Api::V3::FloorsFilter < Api::V3::BaseFilter

  def collection
    floors = self.resource

   return self.with_associations(floors)
  end

end
