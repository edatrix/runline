class AddRunIdToRunTable < ActiveRecord::Migration
  def change
    add_column :runs, :mmf_identifier, :integer
  end
end
