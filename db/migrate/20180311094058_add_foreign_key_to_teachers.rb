class AddForeignKeyToTeachers < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :teachers, :users
  end
end
