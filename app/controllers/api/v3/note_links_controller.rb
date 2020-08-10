class Api::V3::NoteLinksController < Api::V3::BaseController

	def index
		@note_links = Api::V3::NoteLinksFilter.new(NoteLink.all, params).collection
		render :json => array_serializer(@note_links)
	end

	def show
		@note_link = NoteLink.find_by_id(params[:id])
		return render :json => [] unless !@note_link.blank?
		render :json => @note_link.render_api
	end

	def create
		@note_link = NoteLink.new(permitted_params)
		return render :json => [] unless @note_link.save
		render(
			json: @note_link.render_api,
			status: 201,
			location: api_v3_note_link_path(@note_link.id)
		)
	end

	def update
		@note_link = NoteLink.find_by_id(params[:id])
		return render :json => [] unless @note_link.update_attributes(permitted_params)
		render(
			json: @note_link.render_api,
			status: 201,
			location: api_v3_note_link_path(@note_link.id)
		)
	end

	def destroy
		@note_link = NoteLink.find(params[:id])
		return api_error(status: 422, errors: @note_link.errors) unless @note_link.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_note_link_path(@note_link.id)
		)
	end

	private

	def permitted_params
		params.require(:note_link).permit(
			:note_id,
			:real_estate_id,
			:user_id
		)
	end

	def array_serializer note_links
		note_links_serialized = Array.new
		note_links.each do |note_link|
			note_links_serialized.push(note_link.render_api)
		end
		note_links_serialized
	end

end
