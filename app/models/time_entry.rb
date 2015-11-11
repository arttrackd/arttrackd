class TimeEntry < ActiveRecord::Base
  belongs_to  :project
  validates   :total_time, numericality: { greater_than: 0 }, on: :update

end
