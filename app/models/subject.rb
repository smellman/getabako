class Subject < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :title, :image
  validate :title, :presence => true, :uniqueness => true
end
