class AddForwardOnAttributesToSubscriptionNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :subscription_notifications, :forward_on_status, :string
    add_column :subscription_notifications, :forward_on_msg, :text
  end
end
