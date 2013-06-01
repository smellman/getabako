class Question < ActiveRecord::Base
  attr_accessible :user, :matter, :title, :subject, :level
  belongs_to :user
  belongs_to :subject
  has_many :answers
  validates :matter, :presence => true
  validates :title, :presence => true
  validates :level, :presence => true
  validates :user, :presence => true

  scope :not_answered, includes(:answers).where('answers.answered_time' => nil)

  def get_not_answered_answer
    Answer.where(:question_id => self.id).not_answered
  end
end
