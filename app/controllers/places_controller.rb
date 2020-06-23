class PlacesController < ApplicationController
  def index
    @places = Place.all
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)

    if @place.save
      redirect_to :index, notice: 'Success'
    else
      flash.now[:alert] = 'Failure'
      render :new
    end
  end

  private

  def place_params
    params.require(:place).permit(%i(name lat lon))
  end
end
