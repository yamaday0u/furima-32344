class RenameShippingIdColumnToItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :shipping_id, :shipping_area_id
  end
end
