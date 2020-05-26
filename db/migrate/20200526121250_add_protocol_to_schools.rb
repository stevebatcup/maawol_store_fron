class AddProtocolToSchools < ActiveRecord::Migration[6.0]
  def change
    add_column :schools, :protocol, :string
  end
end
