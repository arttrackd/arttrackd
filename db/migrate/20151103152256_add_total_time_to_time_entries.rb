class AddTotalTimeToTimeEntries < ActiveRecord::Migration
  def change
    add_column :time_entries, :total_time, :time
  end
end
