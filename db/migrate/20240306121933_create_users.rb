class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, index: { unique: true }
      t.string :password_digest
      t.integer :role, default: 1

      t.timestamps
    end
  end
end
