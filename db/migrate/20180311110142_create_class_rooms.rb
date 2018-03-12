class CreateClassRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :class_rooms do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.belongs_to :teacher, index: true

      t.timestamps
    end
    add_index :class_rooms, :name, unique: true
  end
end
