# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string(255)
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  sign_in_count          :integer          default(0), not null
#  unlock_token           :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint
#
# Indexes
#
#  index_accounts_on_email                 (email) UNIQUE
#  index_accounts_on_reset_password_token  (reset_password_token) UNIQUE
#  index_accounts_on_user_id               (user_id)
#
class Account < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :lockable,
         :omniauthable, omniauth_providers: %i(google_oauth2)

  belongs_to :user

  class << self
    def from_omniauth(access_token)
      data = access_token.info
      account = Account.where(email: data['email']).first

      account ||= Account.create(
        name: data['name'],
        email: data['email'],
        password: Devise.friendly_token[0, 20]
      )

      account
    end
  end

  # デフォルトでログイン時に remember_me を true にする
  def remember_me
    true
  end
end
