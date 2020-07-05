class PlacesController < ApplicationController
  before_action :set_place, only: %i(show)

  def index
    @places = Place.all
    @js_vars = @places
  end

  def show; end

  def new
    @form = Places::Create.new
  end

  def create
    outcome = Places::Create.run(places_create_params.to_h)

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

  def places_create_params
    params.require(:places_create).permit(:name, :lat, :lng, :note, images: [])
  end
end
