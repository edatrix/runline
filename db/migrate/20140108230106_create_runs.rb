class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.string :name
      t.integer :distance
      t.integer :run_time
      t.string :workout_datetime
      t.integer :user_id
      t.timestamps
    end
  end
end
