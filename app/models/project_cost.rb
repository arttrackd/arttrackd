class ProjectCost < ActiveRecord::Base
  belongs_to :project
  validates :cost_type, presence: true
  validates :amount, presence: true

  def self.search(q, user_id)
    ProjectCost.joins(:project).where("user_id = ? AND name LIKE ?", user_id, q).uniq
  end
end
