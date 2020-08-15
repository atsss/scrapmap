require 'batch/base'

module Batches
  class MoveToInfoFromPlaceToLocation < Batch::Base
    def execute(_args)
      Channel.without_deleted.each do |channel|
        channel.places.each do |place|
          location = Location.create!(lat: place.lat, lng: place.lng)
          place.update!(location: location)
        end
      end
    end
  end
end
