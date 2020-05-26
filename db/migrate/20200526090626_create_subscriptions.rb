class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.integer :school_id
      t.string :subscription_id
      t.string :platform
      t.integer :status

      t.timestamps
    end
  end
end
