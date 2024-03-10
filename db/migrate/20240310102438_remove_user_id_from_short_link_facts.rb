class RemoveUserIdFromShortLinkFacts < ActiveRecord::Migration[7.1]
  def up
    safety_assured { remove_column :short_link_facts, :user_id, :integer }
  end

  def down
    add_column :short_link_facts, :user_id, :integer
    add_index :short_link_facts, [:user_id, :created_at]
  end
end
