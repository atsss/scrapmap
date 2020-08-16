module Front
  class DraftsController < FrontController
    def new
      authorize Place

      @form = Places::Draft.new
    end

    def create
      skip_authorization

      outcome = Places::Draft.run(places_draft_params.merge(user: @current_user))

      if outcome.valid?
        message = "Saved in #{outcome.result.channel.name} folder of #{outcome.result.channel.community.name}"
        redirect_to place_path(outcome.result), notice: message
      else
        @form = Places::Draft.new(places_draft_params)

        flash.now[:alert] = outcome.errors.full_messages.join(', ')
        render :new
      end
    end

    private

    def places_draft_params
      nilfiy(
        params
          .require(:places_draft)
          .permit(:lat, :lng, :images)
      )
    end

    def nilfiy(custom_params)
      custom_params.reject { |_k, v| v.blank? }
    end
  end
end
