module Front
  class ChannelsController < FrontController
    before_action :set_channel, only: :show

    def index
      @channels = Channel.all
    end

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
      @channel = Channel.new
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

    private

    def set_channel
      @channel = Channel.find(params[:id])
    end

    def channel_params
      params.require(:channel).permit(:name)
    end

    def js_vars
      url_helpers = Rails.application.routes.url_helpers

      @channel.places.map do |place| # FIXME: リファクタリング
        place_vars = place.attributes.slice('name', 'lat', 'lng')
        vistors = place
                    .notes
                    .includes(:user)
                    .map { |note| note.user.name }
                    .uniq
                    .join(', ')

        place_vars.merge(path: url_helpers.place_path(place), vistors: vistors)
      end
    end
  end
end
