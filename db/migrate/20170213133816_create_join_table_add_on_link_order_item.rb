class CreateJoinTableAddOnLinkOrderItem < ActiveRecord::Migration[5.0]
  def change
    create_join_table :add_on_links, :order_items do |t|
      t.index [:add_on_link_id, :order_item_id], name: 'add_on_link_order_item'
      t.index [:order_item_id, :add_on_link_id], name: 'order_item_add_on_link'
    end
  end
end
