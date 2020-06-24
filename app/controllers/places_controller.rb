class PlacesController < ApplicationController
  def index
    @places = Place.all
  end

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

  def places_create_params
    params.require(:places_create).permit(%i(name lat lon note))
  end
end
