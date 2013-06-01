class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question
      t.references :user
      t.text :body
      t.text :correction
      t.timestamps
      t.datetime :answered_time
      t.datetime :corrected_time
    end
  end
end
