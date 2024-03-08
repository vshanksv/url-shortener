class CreateShortLinkFacts < ActiveRecord::Migration[7.1]
  def change
    create_table :short_link_facts do |t|
      t.string :short_url
      t.integer :user_id
      t.string :ip

      t.timestamps

      t.index [:user_id, :created_at]
    end
  end
end
