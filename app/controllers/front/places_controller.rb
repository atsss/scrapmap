module Front
  class PlacesController < FrontController
    before_action :set_place, only: %i(show edit update)

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
        message = if outcome.result.need_check?
                    'It takes time to get the location info from Google Maps URL'
                  else
                    'Success'
                  end

        redirect_to place_path(outcome.result), notice: message
      else
        @form = Places::Create.new(places_create_params)

        flash.now[:alert] = outcome.errors.full_messages.join(', ')
        render :new
      end
    end

    def edit; end

    def update
      outcome = Places::Update.run(place_params.merge(place: @place).to_h)

      if outcome.valid?
        message = if outcome.result.need_check?
                    'It takes time to get the location info from Google Maps URL'
                  else
                    'Success'
                  end

        redirect_to place_path(outcome.result), notice: message
      else
        @form = Places::Create.new(places_create_params)

        flash.now[:alert] = outcome.errors.full_messages.join(', ')
        render :edit
      end
    end

    private

    def set_place
      @place = Place.find(params[:id])
    end

    def place_params
      params.require(:place).permit(%i(name google_map_url))
    end

    # FIXME: 複数登録できるようにする
    def places_create_params
      params
        .require(:places_create)
        .permit(:channel_id, :name, :lat, :lng, :google_map_url, :note, :images)
    end
  end
end
