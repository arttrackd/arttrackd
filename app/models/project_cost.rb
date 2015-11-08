class ProjectCost < ActiveRecord::Base
  belongs_to :project
  validates :cost_type, presence: true
   validates :amount, presence: true

  def self.search(search)
    if search
      @project_costs = ProjectCost.where("cost_type LIKE ?", "%#{search}%")
    end
  end
end
