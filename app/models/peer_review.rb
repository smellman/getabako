class PeerReview < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :answer, :user, :question_body, :reply
  belongs_to :answer
  belongs_to :user
  
  validates :answer, :presence => true
  validates :question_body, :presence => true
  
  scope :not_replyed, where(:reply_time => nil)
  scope :replyed, where(PeerReview.arel_table[:reply_time].not_eq(nil)) 
  
  def replyed?
    self.reply_time.nil? ? false : true
  end

  def save
    if not self.replyed? and not self.reply.blank?
      self.reply_time = DateTime.now
    end
    super
  end

end
