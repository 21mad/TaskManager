class User < ApplicationRecord
    has_secure_password
    validates_uniqueness_of :username
    validates_presence_of :username
    validates_presence_of :password
    validates_confirmation_of :password

    has_many :folders
end
