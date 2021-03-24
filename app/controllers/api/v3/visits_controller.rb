class Api::V3::VisitsController < Api::V3::BaseController

	def index
		@visits = Api::V3::VisitsFilter.new(Visit.all, params).collection
		render :json => array_serializer(@visits)
	end

	def show
		@visit = Visit.find_by_id(params[:id])
		return render :json => [] unless !@visit.blank?
		render :json => @visit.render_api
	end

	def create
		if Visit.exists?(:real_estate_id => params[:real_estate_id], :agent_id => params[:agent_id], :kind => params[:kind], user_id: params[:user_id])
			params[:id] = Visit.find_by(real_estate_id: params[:real_estate_id], agent_id: params[:agent_id], kind: params[:kind], user_id: params[:user_id]).id
			Visit.find_by_id(params[:id]).touch
		# elsif Visit.exists?(:user_id => params[:user_id], :agent_id => params[:agent_id], :kind => params[:kind])
		# 	puts "okok"
		# 	params[:id] = Visit.find_by(user_id: params[:user_id], agent_id: params[:agent_id], kind: params[:kind]).id
		# 	Visit.find_by_id(params[:id]).touch
		else
			@visit = Visit.new(permitted_params)
			return render :json => [] unless @visit.save
			render(
				json: @visit.render_api,
				status: 201,
				location: api_v3_visit_path(@visit.id)
			)
		end
	end

	def update
		@visit = Visit.find_by_id(params[:id])
		return render :json => [] unless @visit.update_attributes(permitted_params)
		render(
			json: @visit.render_api,
			status: 201,
			location: api_v3_visit_path(@visit.id)
		)
	end

	def destroy
		@visit = Visit.find(params[:id])
		return api_error(status: 422, errors: @visit.errors) unless @visit.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_visit_path(@visit.id)
		)
	end

	private

	def permitted_params
		params.require(:visit).permit(
			:kind,
			:date,
			:verified,
			:agent_id,
			:real_estate_id,
			:user_id
		)
	end

	def array_serializer visits
		visits_serialized = Array.new
		visits.each do |visit|
			visits_serialized.push(visit.render_api)
		end
		visits_serialized
	end

end
