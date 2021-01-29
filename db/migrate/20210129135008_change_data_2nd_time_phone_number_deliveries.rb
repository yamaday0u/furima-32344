class ChangeData2ndTimePhoneNumberDeliveries < ActiveRecord::Migration[6.0]
  def up
    change_column :deliveries, :phone_number, :string
  end
  def down
    change_column :deliveries, :phone_number, :text
  end
end
