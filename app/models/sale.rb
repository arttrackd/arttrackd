class Sale < ActiveRecord::Base
  belongs_to :project
  belongs_to :sales_channel
  validates :gross, presence: true
  validates :date, presence: true

  def self.search(q)
     @sales = Sale.where("date LIKE ?", q)
     @sales += Sale.where(project_id: Project.where("name LIKE ?", q))
     return @sales
   end
end
# @sale = Sale.where(project_id: Project.where(user_id: @user.id)).limit(50)
# @sale = Sale.joins(:project).where("date LIKE ? OR name LIKE ?", "%#{:search}%", "%#{:search}%")
