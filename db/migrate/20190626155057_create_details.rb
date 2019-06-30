class CreateDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :details do |t|
      t.references :plan, foreign_key: true
      t.string :destination
      t.integer :amount, default: 0
      t.string :content
      t.datetime :start_at
      t.datetime :end_at
      t.string :address
      t.string :site_url
      t.string :phone

      t.timestamps
    end
  end
end
