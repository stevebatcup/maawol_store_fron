class CreateSubscriptionNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :subscription_notifications do |t|
      t.integer :subscription_id
      t.string :notification_id
      t.string :method

      t.timestamps
    end
  end
end
