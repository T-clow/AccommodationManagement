# db/migrate/20231127064557_create_reservations.rb

class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :number_of_people
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end

    # 以下のように外部キー制約を追加
    add_foreign_key :reservations, :rooms
  end
end
