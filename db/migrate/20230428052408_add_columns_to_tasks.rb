class AddColumnsToTasks < ActiveRecord::Migration[7.0]
  def change
    # add_column :tasks, :user_id, :integer
    add_column :tasks, :completed, :boolean, default: false
    add_column :tasks, :progress, :integer, default: 0
    add_column :tasks, :incontext, :boolean, default: false

    # add_index :tasks, :user_id
  end

  # def up
  # end

  # def down
  # end

  # def fill_cached_val
  #   [].each |item|
  #     val = ...
  #     Item.update_attributes :cached_value, val
  #   end
  # end
end
