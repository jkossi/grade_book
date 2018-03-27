class AddNewColumnsToScores < ActiveRecord::Migration[5.2]
  def change
    rename_column :scores, :class_scores, :cat1
    add_column :scores, :cat2, :decimal, default: 0.00
    add_column :scores, :cat3, :decimal, default: 0.00
    add_column :scores, :cat4, :decimal, default: 0.00
  end
end
