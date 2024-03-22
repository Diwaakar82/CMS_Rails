class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # attr_accessible :username
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

          has_many :posts, dependent: :destroy
          has_many :comments
          has_many :likes, dependent: :destroy
end
