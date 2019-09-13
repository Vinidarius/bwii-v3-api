class Api::V3::AgentsController < Api::V3::BaseController

	def index
		@agents = Api::V3::AgentsFilter.new(Agent.all, params).collection
		render :json => array_serializer(@agents, "classic")
	end

	def show
		@agent = Agent.find_by_id(params[:id])
		return render :json => [] unless !@agent.blank?
		render :json => @agent.render_api
	end

	def list
		@agents = Agent.all
		render :json => array_serializer(@agents, "list")
	end

	def connect
		@agent = Agent.find_by_id(params[:id])
		return render :json => [] unless !@agent.blank?
		render :json => @agent.render_connect_api
	end

	def create
		@agent = Agent.new(permitted_params)
		return render :json => [] unless @agent.save
		render(
			json: @agent.render_api,
			status: 201,
			location: api_v3_agent_path(@agent.id)
		)
	end

	def update
		@agent = Agent.find_by_id(params[:id])
		return render :json => [] unless @agent.update_attributes(permitted_params)
		render(
			json: @agent.render_api,
			status: 201,
			location: api_v3_agent_path(@agent.id)
		)
	end

	def destroy
		@agent = Agent.find(params[:id]);
		@agent.archived = true;
		return render :json => [] unless @agent.save
		render(
			json: @agent.render_api,
			status: 201,
			location: api_v3_agent_path(@agent.id)
		)
	end

	private

	def permitted_params
		params.require(:agent).permit(
			:email,
			:firstname,
			:lastname,
			:phone_number,
			:archived,
			:compagny_id
		)
	end

	def array_serializer agents, route
		agents_serialized = Array.new
		agents.each do |agent|
			case route
				when "classic"
					agents_serialized.push(agent.render_api)
				when "list"
					agents_serialized.push(agent.render_list_api)
			end
		end
		agents_serialized
	end

end
