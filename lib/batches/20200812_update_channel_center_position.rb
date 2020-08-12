require 'batch/base'

module Batches
  class UpdateChannelCenterPosition < Batch::Base
    def execute(_args)
      Channel.all.each do |channel|
        next if channel.places.blank?

        places = channel.places.reject(&:need_check?)
        size = places.size

        next if size.zero?

        center_lat = places.sum(&:lat) / size
        center_lng = places.sum(&:lng) / size

        channel.update!(center_lat: center_lat, center_lng: center_lng)
      end
    end
  end
end
