class ProjectCost < ActiveRecord::Base
  belongs_to :project
  validates :cost_type, presence: true
  validates :amount, presence: true

end
