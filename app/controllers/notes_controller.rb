class NotesController < ApplicationController
  before_action :set_place

  def new
    @note = Note.new
  end

  def create
    outcome = Notes::Create.run(note_params.merge(place: @place).to_h)

    if outcome.valid?
      redirect_to place_path(@place), notice: 'Success'
    else
      @note = Note.new(note_params)

      flash.now[:alert] = outcome.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def set_place
    @place = Place.find(params[:place_id])
  end

  # FIXME: 複数登録できるようにする
  def note_params
    params.require(:note).permit(:content, :images)
  end
end
