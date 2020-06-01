class AddExtraFieldsToGenres < ActiveRecord::Migration[6.0]
  def change
  	add_column	:genres, :genre, :string
  	add_column	:genres, :base_url, :string
  	add_column	:genres, :contact_name, :string
  	add_column	:genres, :contact_email, :string
  	rename_column	:genres, :name, :trade_name
  end
end
