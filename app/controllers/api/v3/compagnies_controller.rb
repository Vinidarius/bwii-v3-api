class Api::V3::CompagniesController < Api::V3::BaseController

	def index
    @compagnies = Api::V3::CompagniesFilter.new(Compagny.all, params).collection
    render :json => array_serializer(@compagnies, "classic")
  end

  def show
    @compagny = Compagny.find_by_id(params[:id])
    return render :json => [] unless !@compagny.blank?
		render :json => @compagny.render_api
  end

	def list
		@compagnies = Compagny.all
		render :json => array_serializer(@compagnies, "list")
	end

	def create
		@compagny = Compagny.new(permitted_params)
		return render :json => [] unless @compagny.save
		render(
      json: @compagny.render_api,
      status: 201,
      location: api_v3_compagny_path(@compagny.id)
    )
	end

  def update
		@compagny = Compagny.find_by_id(params[:id])
		return render :json => [] unless @compagny.update_attributes(permitted_params)
    render(
      json: @compagny.render_api,
      status: 201,
      location: api_v3_compagny_path(@compagny.id)
    )
  end

	def destroy
		@compagny = Compagny.find(params[:id])
		@compagny.archived = true;
		return render :json => [] unless @compagny.save
		render(
			json: @compagny.render_api,
			status: 201,
			location: api_v3_compagny_path(@compagny.id)
		)
  end

  private

  def permitted_params
    params.require(:compagny).permit(
			:name,
			:email,
			:background_color,
			:text_color,
			:comparution_text,
			:archived
    )
  end

  def array_serializer compagnies, route
    compagnies_serialized = Array.new
    compagnies.each do |compagny|
			case route
				when "classic"
					compagnies_serialized.push(compagny.render_api)
				when "list"
					compagnies_serialized.push(compagny.render_list_api)
			end
    end
		compagnies_serialized
  end

end
