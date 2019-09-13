class Api::V3::NotesController < Api::V3::BaseController

	def index
		@notes = Api::V3::NotesFilter.new(Note.all, params).collection
		render :json => array_serializer(@notes)
	end

	def show
		@note = Note.find_by_id(params[:id])
		return render :json => [] unless !@note.blank?
		render :json => @note.render_api
	end

	def create
		@note = Note.new(permitted_params)
		return render :json => [] unless @note.save
		render(
			json: @note.render_api,
			status: 201,
			location: api_v3_note_path(@note.id)
		)
	end

	def update
		@note = Note.find_by_id(params[:id])
		return render :json => [] unless @note.update_attributes(permitted_params)
		render(
			json: @note.render_api,
			status: 201,
			location: api_v3_note_path(@note.id)
		)
	end

	def destroy
		@note = Note.find(params[:id])
		return api_error(status: 422, errors: @note.errors) unless @note.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_note_path(@note.id)
		)
	end

	private

	def permitted_params
		params.require(:note).permit(
			:title,
			:date,
			:body,
			:agent_id,
			:real_estate_id,
			:user_id
		)
	end

	def array_serializer notes
		notes_serialized = Array.new
		notes.each do |note|
			notes_serialized.push(note.render_api)
		end
		notes_serialized
	end

end
