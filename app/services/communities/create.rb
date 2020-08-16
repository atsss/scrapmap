module Communities
  class Create < ApplicationService
    string :name
    array :user_ids

    def execute
      transaction do
        community = Community.create!(name: name)
        user_ids.each { |user_id| community.user_communities.create!(user_id: user_id) }

        community.channels.create!(kind: :draft, name: '下書き')
        Channel::DEFAULT_NAMES.each { |name| community.channels.create!(name: name) }
      end
    end
  end
end
