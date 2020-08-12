module Front
  class ChannelsController < FrontController
    before_action :set_channel, only: %i(show edit update)

    def show
      @js_vars = js_vars
      @images = ActiveStorage::Attachment
                  .where(
                    record_type: 'Note',
                    record_id: Note.where(place_id: @channel.places.ids).ids
                  )
                  .order(id: :desc)
    end

    def new
      community_id = params[:community_id] || @current_user.private_community.id

      @channel = Channel.new(community_id: community_id)
    end

    def create
      @channel = Channel.new(channel_params)

      if @channel.save
        redirect_to channel_path(@channel), notice: 'Success'
      else
        flash.now[:alert] = @channel.errors.full_messages.join(', ')
        render :new
      end
    end

    def edit; end

    def update
      if @channel.update(channel_params)
        redirect_to channel_path(@channel), notice: 'Success'
      else
        flash.now[:alert] = @channel.errors.full_messages.join(', ')
        render :edit
      end
    end

    private

    def set_channel
      @channel = Channel.find(params[:id])
    end

    def channel_params
      params.require(:channel).permit(%i(name community_id))
    end

    def js_vars
      url_helpers = Rails.application.routes.url_helpers
      base = { lat: @channel.center_lat, lng: @channel.center_lng }

      places = @channel.places.includes(notes: :user).map do |place| # FIXME: リファクタリング
        next if place.need_check?

        place_vars = place.attributes.slice('name', 'lat', 'lng')
        vistors = place
                    .notes
                    .map { |note| note.user.name }
                    .uniq
                    .join(', ')

        place_vars.merge(path: url_helpers.place_path(place), vistors: vistors)
      end.compact

      base.merge(places: places)
    end
  end
end
