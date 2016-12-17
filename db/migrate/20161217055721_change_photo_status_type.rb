class ChangePhotoStatusType < ActiveRecord::Migration[5.0]
  def change
  	change_column :photos, :status, :string 
  end
end
