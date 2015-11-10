class Sale < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :sales_channel
  belongs_to :user
  validates :gross, presence: true
  validates :date, presence: true

  def self.search(q)
    search =  "%#{q}%"
    Sale.includes(:project).where(project_id: Project.search(Project, q).pluck(:id))
  end
end
