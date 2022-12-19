class User < ApplicationRecord
    has_secure_password
    validates_uniqueness_of :username
    validates_presence_of :username
    validates_presence_of :password
    validates_confirmation_of :password
    validates_uniqueness_of :email
    validates_presence_of :email
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: I18n.t("is_invalid") } # email validation
    validates :username, format: { with: /\A(?=.{5,})/x, message: I18n.t("is_short") }

    PASSWORD_FORMAT = /\A
    (?=.{8,})          # Must contain 8 or more characters
    (?=.*\d)           # Must contain a digit
    (?=.*[a-z])        # Must contain a lower case character
    (?=.*[A-Z])        # Must contain an upper case character
    (?=.*[[:^alnum:]]) # Must contain a symbol
    /x
    # validates :password, format: { with: PASSWORD_FORMAT, message: "is not secure. Must contain 8 or more characters" }
    # it works, but I'm too lazy to come up with passwords...

    has_many :folders, dependent: :destroy
end
