class Project < ActiveRecord::Base
  belongs_to :user
  has_many :time_entries
  has_many :sales
  validates :name, presence: true

  def total_time
    # Set a default value for time entry total_time field later
    time_entries.reduce(0.0){|sum, t| sum + (t.total_time || 0)}
  end

  def estimated_value
    user.hourly_rate * total_time/360
  end

end
