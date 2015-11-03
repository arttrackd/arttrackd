class Project < ActiveRecord::Base
  belongs_to  :user
  has_many    :time_entries
  has_many    :sales

  def get_time
    project_time_entries = TimeEntry.where('project_id = ?', id)
    project_time_entries.sum('total_time')
  end
end
