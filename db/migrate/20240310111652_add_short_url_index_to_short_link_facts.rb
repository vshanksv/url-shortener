class AddShortUrlIndexToShortLinkFacts < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def change
    add_index :short_link_facts, :short_url, algorithm: :concurrently
  end
end
