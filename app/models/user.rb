class User < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :password_digest, :password, :password_confirmation
  has_secure_password
  validate :name, :presence => true, :uniqueness => true
  validate :password_digest, :presence => true
  
end
