class CreateSchools < ActiveRecord::Migration[6.0]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :domain
      t.integer :port
      t.string :access_token

      t.timestamps
    end
  end
end
