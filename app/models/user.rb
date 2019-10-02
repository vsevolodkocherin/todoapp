class User < ApplicationRecord
  has_secure_password

  validates :username, uniqueness: { case_sensitive: false }
  validates :token, presence: true

  has_many :projects
end
