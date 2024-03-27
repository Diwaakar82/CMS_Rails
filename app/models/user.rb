class User < ApplicationRecord
    has_secure_password
    before_save :downcase_email
    validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, uniqueness: true

    has_many :posts
    has_many :comments
    has_many :likes, dependent: :destroy
    
private
    def downcase_email
        self.email = email.downcase
    end
end
