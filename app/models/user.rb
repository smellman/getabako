class User < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :password_digest, :password, :password_confirmation
  has_secure_password
  validates :name, :presence => true, :uniqueness => true
  validates :password_digest, :presence => true
  has_many :answers
  has_many :questions
end
