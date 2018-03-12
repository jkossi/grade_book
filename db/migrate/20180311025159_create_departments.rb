class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.references :user, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
