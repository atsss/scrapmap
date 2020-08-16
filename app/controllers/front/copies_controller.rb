module Front
  class CopiesController < FrontController
    before_action :set_place

    def new
      authorize @place
    end

    def create
      authorize Place.new(channel_id: place_params[:channel_id])

      outcome = Places::Copy.run(place_params.to_h.merge(place: @place))

      if outcome.valid?
        message = "Copied in #{outcome.result.channel.name} folder of #{outcome.result.channel.community.name}"
        redirect_to place_path(outcome.result), notice: message
      else
        @place.assign_attributes(place_params)

        flash.now[:alert] = outcome.errors.full_messages.join(', ')
        render :new
      end
    end

    private

    def set_place
      @place = Place.find(params[:place_id])
    end

    def place_params
      params.require(:place).permit(:channel_id, :name, :kind)
    end
  end
end
