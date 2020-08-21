class AddLockableColmunsToAccounts < ActiveRecord::Migration[6.0]
  def change
      add_column :accounts, :failed_attempts, :integer, default: 0, null: false, after: :last_sign_in_ip
      add_column :accounts, :unlock_token, :string, after: :failed_attempts
      add_column :accounts, :locked_at, :datetime, after: :unlock_token
  end
end
