class ProjectCost < ActiveRecord::Base
  belongs_to :project
  validates :cost_type, presence: true
  validates :amount, presence: true

  def self.search(pc, q)
    search =  "%#{q}%"
    project_costs_search = Project.where(id: pc.where("cost_type LIKE ?", search).pluck(:project_id)).arel.constraints.reduce(:and)
    project_search = Project.search(Project, q).arel.constraints.reduce(:and)
    Project.where(project_search.or(project_costs_search))
  end
end
