class ProjectCost < ActiveRecord::Base
  belongs_to :project


  def self.search(search)
    if search
      @project_costs = ProjectCost.where("cost_type LIKE ?", "%#{search}%")
    end
  end
end
