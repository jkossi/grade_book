class CreateAcademicSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :academic_sessions do |t|
      t.string :term
      t.string :year
      t.date :start_date
      t.date :end_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
