class SalesGoal < ActiveRecord::Base
  belongs_to :user
  validates :amount, presence: true
  validates :length_of_time, presence: true
  validates :start_time, presence: true

end
