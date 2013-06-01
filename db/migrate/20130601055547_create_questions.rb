class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :user
      t.string :title
      t.text :matter
      t.integer :level
      t.references :subject
      t.timestamps
    end
  end
end
