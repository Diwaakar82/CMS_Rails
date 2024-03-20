class Post < ApplicationRecord
    validates :title, presence: true, length: { minimum: 5 }
    validates :description, presence: true, length: { minimum: 5 }

    has_and_belongs_to_many :categories
    has_many :comments, dependent: :destroy
end
