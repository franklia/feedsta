class Photo < ApplicationRecord
  belongs_to :user
  mount_uploader :url, PhotoUploader
  enum status: [ :saved, :pending, :posted ]
end
