class ProjectCost < ActiveRecord::Base
  belongs_to :project
  validates :cost_type, presence: true
   validates :amount, presence: true

  def self.search(q)
    @project_costs = ProjectCost.where("cost_type LIKE ?", q)
    @project_costs += ProjectCost.where(project_id: Project.where("name LIKE ?", q))
    return @project_costs
  end
end
