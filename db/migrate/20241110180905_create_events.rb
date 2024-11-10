class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.datetime :date
      t.text :description
      t.datetime :end_time
      t.string :location
      t.datetime :start_time
      t.string :title

      t.timestamps
    end
  end
end
