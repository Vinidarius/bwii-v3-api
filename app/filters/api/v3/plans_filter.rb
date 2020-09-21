class Api::V3::PlansFilter < Api::V3::BaseFilter

  def collection
    plans = self.resource

   return self.with_associations(plans)
  end

end
