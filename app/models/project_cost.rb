class ProjectCost < ActiveRecord::Base
  belongs_to :project
  validates :cost_type, presence: true
  validates :amount, presence: true

  def self.search(pc, q)
    project_costs = pc.where(project_id: Project.where("name LIKE ?", q))
    project_costs.uniq!
  end
end
