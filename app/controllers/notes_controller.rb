class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  # before_action :add_breadcrumb_show, only: [:show]

  # GET /notes
  def index
    @notes = @noteable.notes
    respond_with(@notes)
  end

  # GET /notes/1
  def show
    respond_with(@note)
  end

  # GET /notes/new
  def new
    @note = @noteable.notes.new
    respond_with(@note)
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  def create
    @note = @noteable.notes.build(note_params.merge({date: Date.today, user_id: current_user.id}))

    respond_with(@note, location: location) do |format|
      if @note.save
        format.js { head :created }
      else
        format.js { render json: @note.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  def update
    respond_with(@note, location: location) do |format|
      if @note.update(note_params.merge({date: Date.today, user_id: current_user.id}))
        format.js { head :ok }
      else
        format.js { render json: @note.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy
    respond_with(@note, location: location) do |format|
      format.js { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def note_params
      params.require(:note).permit(:task_id, :user_id, :date, :description)
    end

    def location
      polymorphic_path(@noteable)
    end

end
