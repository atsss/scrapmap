module Users
  class Create < ApplicationService
    string :name
    string :email
    string :password

    def execute
      transaction do
        user = User.create!(name: name)
        user.create_account!(email: email, password: password)

        community = user.communities.create!(name: 'Personal', kind: :private)
        Channel::DEFAULT_NAMES.each { |name| community.channels.create!(name: name) }
      end
    end
  end
end
