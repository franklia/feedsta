class InstaAccount < ApplicationRecord
  belongs_to :user
  # validates :name, :username, :token, :profile_pic, :instagram_id, :user_id, :country, :phone, presence: true
end
