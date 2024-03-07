class CreateShortLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :short_links do |t|
      t.string :target_url
      t.string :short_url, index: { unique: true }
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
