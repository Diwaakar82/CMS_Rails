class Category < ApplicationRecord
    validates :title, presence: true, length: { minimum: 3 }
    has_and_belongs_to_many :posts
end
