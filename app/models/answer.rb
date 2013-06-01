# -*- coding: utf-8 -*-
class Answer < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :question, :user, :body, :correction
  belongs_to :question
  belongs_to :user

  scope :not_answered, where(:answered_time => nil)
  scope :not_corrected, where(:corrected_time => nil)
  scope :completed, where(Answer.arel_table[:answered_time].not_eq(nil)).where(Answer.arel_table[:corrected_time].not_eq(nil))

  def answered?
    self.answered_time.nil? ? false : true
  end

  def corrected?
    self.corrected_time.nil? ? false : true
  end

  def save
    if not self.answered? and not self.body.blank?
      self.answered_time = DateTime.now
    end
    if not self.corrected? and not self.correction.blank?
      self.corrected_time = DateTime.now
    end
    super
  end
    
end
