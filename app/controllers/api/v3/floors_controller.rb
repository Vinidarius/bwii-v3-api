class Api::V3::FloorsController < Api::V3::BaseController

	def index
    @floors = Api::V3::FloorsFilter.new(Floor.all, params).collection
    render :json => array_serializer(@floors)
  end

  def show
    @floor = Floor.find_by_id(params[:id])
    return render :json => [] unless !@floor.blank?
		render :json => @floor.render_api
  end

	def create
		@floor = Floor.new(permitted_params)
		return render :json => [] unless @floor.save
		render(
      json: @floor.render_api,
      status: 201,
      location: api_v3_floor_path(@floor.id)
    )
	end

  def update
		@floor = Floor.find_by_id(params[:id])
		return render :json => [] unless @floor.update_attributes(permitted_params)
    render(
      json: @floor.render_api,
      status: 201,
      location: api_v3_floor_path(@floor.id)
    )
  end

	def destroy
		@floor = Floor.find(params[:id]);
		return api_error(status: 422, errors: @floor.errors) unless @floor.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_floor_path(@floor.id)
		)
	end

  private

  def permitted_params
    params.require(:floor).permit(
			:name,
			:area,
			:divisible,
			:terrace,
			:number,
			:lot_number,
			:real_estate_id
    )
  end

  def array_serializer floors
    floors_serialized = Array.new
    floors.each do |floor|
			floors_serialized.push(floor.render_api)
    end
		floors_serialized
  end

end
