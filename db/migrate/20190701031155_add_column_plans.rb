class AddColumnPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :public, :boolean, default: false, null: false
  end
end
