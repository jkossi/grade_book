class AddsClosedToAcademicSessions < ActiveRecord::Migration[5.2]
  def change
    add_column :academic_sessions, :closed, :boolean, default: false
  end
end
