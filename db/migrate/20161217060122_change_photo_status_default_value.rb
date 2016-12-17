class ChangePhotoStatusDefaultValue < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :photos, :status, from: 0, to: 'saved'
  end
end
