class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :items, class_name: 'UserItem', inverse_of: :user

  enum platform: [:Steam, :PSN, :Xbox]

end
