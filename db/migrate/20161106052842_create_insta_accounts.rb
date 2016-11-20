class CreateInstaAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :insta_accounts do |t|
      t.string :name
      t.string :username, :null => false
      t.string :token, :null => false
      t.string :profile_pic
      t.integer :instagram_id, :limit => 8
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
