class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :eamil, presence: true, uniqueness: true
end
