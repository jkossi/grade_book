class AddUniqIndexToNameOnDepartments < ActiveRecord::Migration[5.2]
  def change
    add_index :departments, :name, unique: true
    add_index :subjects, :name, unique: true
  end
end
