class RenameFileToUrl < ActiveRecord::Migration[5.0]
  def change
  	rename_column :photos, :file, :url
  end
end
