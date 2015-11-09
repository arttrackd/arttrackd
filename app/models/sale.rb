class Sale < ActiveRecord::Base
  belongs_to :project
  belongs_to :sales_channel
  validates :gross, presence: true
  validates :date, presence: true

  def self.search(s, q)
    search =  "%#{q}%"
    s.where(project_id: Project.search(Project, q).pluck(:id))
  end
end
