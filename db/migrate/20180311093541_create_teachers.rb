class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers, id: false do |t|
      t.boolean :is_class_teacher, default: false
      t.integer :user_id, null: false
      t.timestamps
    end

    add_index :teachers, :user_id, unique: true
  end
end
