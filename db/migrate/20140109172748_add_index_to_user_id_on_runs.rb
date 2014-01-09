class AddIndexToUserIdOnRuns < ActiveRecord::Migration
  def change
    add_index :runs, :user_id
  end
end
