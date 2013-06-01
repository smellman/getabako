class Subject < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :image
  validate :name, :presence => true, :uniqueness => true
end
