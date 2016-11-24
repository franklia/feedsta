class Photo < ApplicationRecord
	# Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :user
  
  enum status: [ :saved, :pending, :posted ]

  mount_uploader :file, FileUploader
end
