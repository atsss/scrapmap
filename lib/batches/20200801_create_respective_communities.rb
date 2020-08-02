require 'batch/base'

module Batches
  class CreateRespectiveCommunities < Batch::Base
    def execute(_args)
      public_community = Community.create!(name: 'Group One')

      User.all.each do |user|
        private_community = Community.create!(name: 'Personal', kind: :private)

        user.communities << private_community
        user.communities << public_community
      end

      Channel.all.each { |channel| channel.update!(community: public_community) }
    end
  end
end
