class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.references :subject, foreign_key: true
      t.references :student, foreign_key: true
      t.references :user, foreign_key: true
      t.references :academic_session, foreign_key: true
      t.decimal :class_scores, default: 0.00
      t.decimal :exam_scores, default: 0.00

      t.timestamps
    end
  end
end
