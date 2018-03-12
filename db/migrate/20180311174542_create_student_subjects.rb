class CreateStudentSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :student_subjects do |t|
      t.references :student, foreign_key: true
      t.references :subject, foreign_key: true
      t.references :user, foreign_key: true
      t.belongs_to :teacher, index: true

      t.timestamps
    end
  end
end
