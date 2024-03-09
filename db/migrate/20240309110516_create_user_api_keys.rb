class CreateUserApiKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :user_api_keys do |t|
      t.string :api_key, index: { unique: true }
      t.integer :user_id

      t.timestamps
    end
  end
end
