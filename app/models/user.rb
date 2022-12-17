class User < ApplicationRecord
    has_secure_password
    validates_uniqueness_of :username
    validates_presence_of :username
    validates_presence_of :password
    validates_confirmation_of :password
    validates_uniqueness_of :email
    validates_presence_of :email
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Invalid email." } 

    has_many :folders, dependent: :destroy
end
