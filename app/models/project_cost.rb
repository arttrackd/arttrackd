class ProjectCost < ActiveRecord::Base
  belongs_to :project
  validates :cost_type, presence: true
  validates :amount, presence: true

  def self.search(q, user_id)
    projects = Project.where("user_id = ? AND name LIKE ?", user_id, q)
    project_costs = ProjectCost.includes(:project).where("cost_type LIKE ?", q)
    project_costs = project_costs.select{|cost| cost.project.user_id == user_id}
    projects += project_costs.map{|cost| cost.project}
    projects
  end
end
