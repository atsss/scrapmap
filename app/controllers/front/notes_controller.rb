module Front
  class NotesController < FrontController
    before_action :set_note, only: %i(edit update destroy)
    before_action :set_place

    def new
      authorize Note

      @note = Note.new
    end

    def create
      authorize Note

      outcome = Notes::Create.run(
        note_params.merge(user: @current_user, place: @place).to_h
      )

      if outcome.valid?
        redirect_to place_path(@place), notice: 'Success'
      else
        @note = Note.new(note_params)

        flash.now[:alert] = outcome.errors.full_messages.join(', ')
        render :new
      end
    end

    def edit
      authorize @note
    end

    def update
      authorize @note

      if @note.update(note_params)
        redirect_to place_path(@note.place), notice: 'Success'
      else
        flash.now[:alert] = @note.errors.full_messages.join(', ')
        render :edit
      end
    end

    def destroy
      authorize @note

      if @note.destroy
        redirect_to place_path(params[:place_id]), notice: 'Success'
      else
        flash.now[:alert] = @note.errors.full_messages.join(', ')
        render :edit
      end
    end

    private

    def set_note
      @note = Note.find(params[:id])
    end

    def set_place
      @place = Place.find(params[:place_id])
    end

    # FIXME: 複数登録できるようにする
    def note_params
      params.require(:note).permit(%i(place_id content images))
    end
  end
end
