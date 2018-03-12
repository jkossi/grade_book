class AddDepartmentIdToClassRooms < ActiveRecord::Migration[5.2]
  def change
    add_reference :class_rooms, :department, foreign_key: true
  end
end
