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
  scope :not_corrected, includes(:answers).where('answers.answered_time is not null').where('answers.corrected_time' => nil)
  scope :completed, includes(:answers).where('answers.answered_time is not null').where('answers.corrected_time is not null')

  def get_not_answered_answer
    Answer.where(:question_id => self.id).not_answered
  end

  def create_answers
    User.where(User.arel_table[:id].not_eq(user.id)).each do |u|
      a = Answer.new
      a.question = self
      a.user = u
      a.save
    end
  end

end
