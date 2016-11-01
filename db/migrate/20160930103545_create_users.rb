class CreateUsers < ActiveRecord::Migration[5.0]
  def change

    create_table :users do |t|
      t.string :name, null: false, default: ''
      t.string :email, null: false, default: ''
      t.string :mobile, null: false, default: ''
      t.string :image
      t.string :password_digest

      t.timestamps
    end

    add_index :users, :email,    unique: true
    add_index :users, :mobile,   unique: true

  end
end
