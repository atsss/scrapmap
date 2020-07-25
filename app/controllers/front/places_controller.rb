module Front
  class PlacesController < FrontController
    before_action :set_place, only: %i(show)

    def show
      @js_vars = @place
    end

    def new
      @form = Places::Create.new(channel_id: params[:channel_id])
    end

    def create
      outcome = Places::Create.run(
        places_create_params.merge(user: @current_user).to_h
      )

      if outcome.valid?
        redirect_to place_path(outcome.result), notice: 'Success'
      else
        @form = Places::Create.new(places_create_params)

        flash.now[:alert] = outcome.errors.full_messages.join(', ')
        render :new
      end
    end

    private

    def set_place
      @place = Place.find(params[:id])
    end

    # FIXME: 複数登録できるようにする
    def places_create_params
      params
        .require(:places_create)
        .permit(:channel_id, :name, :lat, :lng, :note, :images)
    end
  end
end
