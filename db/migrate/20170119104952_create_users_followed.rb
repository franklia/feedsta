class CreateUsersFollowed < ActiveRecord::Migration[5.0]
  def change
    create_table :users_followed do |t|
    	t.integer :user_id
    	t.integer :instagram_id
    	t.string :username
		t.string :full_name
		t.belongs_to :user, foreign_key: true
		t.timestamps
    end
  end
end
