class Project < ActiveRecord::Base
  belongs_to :user
  has_many :time_entries
  has_many :sales
  validates :name, presence: true

  def get_time
    project_time_entries = TimeEntry.where('project_id = ?', id)
    project_time_entries.sum('total_time')
  end

  def estimated_value(project)
    (project.user.hourly_rate * project.get_time)/360
  end


  def search
  end

end
