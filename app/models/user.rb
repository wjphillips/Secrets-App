class User < ActiveRecord::Base
	has_secure_password
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :name, :email, presence: true
	validates :password, presence: true, confirmation: true, length: {in: 6..20}, :if => :password
	validates :email, length: { in: 2..30}, uniqueness: { case_sensitive: false }, format: {with: EMAIL_REGEX}
	has_many :secrets
	has_many :likes, dependent: :destroy
	has_many :secrets_liked, through: :likes, source: :secret
end