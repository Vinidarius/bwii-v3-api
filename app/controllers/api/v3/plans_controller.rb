class Api::V3::PlansController < Api::V3::BaseController

	def index
		@plans = Api::V3::PlansFilter.new(Plan.all, params).collection
		render :json => array_serializer(@plans)
	end

	def show
		@plan = Plan.find_by_id(params[:id])
		return render :json => [] unless !@plan.blank?
		render :json => @plan.render_api
	end

	def create
		@request = Cloudinary::Uploader.upload(params[:base])
		@plan = Plan.new(permitted_params)
		@plan.public_id = @request["public_id"]
		@plan.url = @request["secure_url"]
		@plan.url = @plan.url[0, @plan.url.index('upload') + "upload".size] + "/a_" + params[:angle].to_s + @plan.url[(@plan.url.index('upload') + "upload".size)..@plan.url.size]
		return render :json => [] unless @plan.save
		render(
			json: @plan.render_api,
			status: 201,
			location: api_v3_plan_path(@plan.id)
		)
	end

	def update
		@plan = Plan.find_by_id(params[:id])
		@plan.url = @plan.url[0, @plan.url.index('/a_') + "/a_".size] + params[:angle].to_s + @plan.url[(@plan.url.index('/a_') + @plan.url.split('/')[6].size + 1)..@plan.url.size]
		return render :json => [] unless @plan.update_attributes(permitted_params)
		render(
			json: @plan.render_api,
			status: 201,
			location: api_v3_plan_path(@plan.id)
		)
	end

	def destroy
		@plan = Plan.find(params[:id])
		Cloudinary::Uploader.destroy(@plan.public_id)
		return api_error(status: 422, errors: @plan.errors) unless @plan.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_plan_path(@plan.id)
		)
	end

	private

	def permitted_params
		params.require(:plan).permit(
			:public_id,
			:url,
			:title,
			:position,
			:angle,
			:real_estate_id
		)
	end

	def array_serializer plans
		plans_serialized = Array.new
		plans.each do |plan|
			plans_serialized.push(plan.render_api)
		end
		plans_serialized
	end

end
