class Sale < ActiveRecord::Base
  belongs_to :project
  belongs_to :sales_channel
  validates :gross, presence: true
  validates :date, presence: true


  def self.search(s, q)
    @sales = s.where("date LIKE ?", q)
    @sales += s.where(project_id: Project.where("name LIKE ?", q))
    @sales += s.where(project_id: Project.where("description LIKE ?", q))
    return @sales
  end
end
