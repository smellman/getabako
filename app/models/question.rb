class Question < ActiveRecord::Base
  attr_accessible :user, :matter, :title, :subject, :level
  belongs_to :user
  validate :matter, :presence => true
  validate :title, :presence => true
  validate :level, :presence => true
  validate :user, :presence => true
end
