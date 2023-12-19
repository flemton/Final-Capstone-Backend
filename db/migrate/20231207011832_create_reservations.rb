class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.boolean :available
      t.string :city, null: false

      t.timestamps
    end
  end
end
