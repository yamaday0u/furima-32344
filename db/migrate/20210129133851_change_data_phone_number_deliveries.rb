class ChangeDataPhoneNumberDeliveries < ActiveRecord::Migration[6.0]
  def down
    change_column :deliveries, :phone_number, :varchar
  end
end
