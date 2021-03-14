class User < ApplicationRecord
validates :firstname, :lastname, :email, presence: true
validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },confirmation: { case_sensitive: false },uniqueness: true
end
