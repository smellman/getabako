class CreatePeerReviews < ActiveRecord::Migration
  def change
    create_table :peer_reviews do |t|
      t.references :answer
      t.references :user
      t.text :question_body
      t.text :reply
      t.datetime :reply_time
      t.timestamps
    end
  end
end
