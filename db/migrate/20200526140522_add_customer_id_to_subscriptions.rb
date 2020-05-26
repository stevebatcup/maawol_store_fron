class AddCustomerIdToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :customer_id, :string
  end
end
