class AddVerifiedAtToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :verified_at, :timestamp
  end
end
