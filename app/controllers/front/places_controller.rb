module Front
  class PlacesController < FrontController
    before_action :set_place, only: %i(show edit update)

    def show
      authorize @place

      @js_vars = { lat: @place.lat, lng: @place.lng }
    end

    def new
      authorize Place.new(channel_id: params[:channel_id])

      @form = Places::Create.new(channel_id: params[:channel_id])
    end

    def create
      authorize Place.new(channel_id: places_create_params[:channel_id])

      outcome = Places::Create.run(
        places_create_params.merge(user: @current_user)
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

    def edit
      authorize @place

      @js_vars = { lat: @place.lat, lng: @place.lng }
    end

    def update
      authorize @place

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
      params.require(:place).permit(%i(channel_id name kind lat lng google_map_url))
    end

    # FIXME: 複数登録できるようにする
    def places_create_params
      nilfiy(
        params
          .require(:places_create)
          .permit(:channel_id, :name, :kind, :lat, :lng, :google_map_url, :note, :images)
      )
    end

    def nilfiy(custom_params)
      custom_params.reject { |_k, v| v.blank? }
    end
  end
end
