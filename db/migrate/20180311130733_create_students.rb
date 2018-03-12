class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :gender
      t.references :user, foreign_key: true
      t.belongs_to :teacher, index: true
      t.references :class_room, foreign_key: true
      t.timestamps
    end
  end
end
