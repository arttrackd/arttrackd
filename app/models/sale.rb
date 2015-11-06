class Sale < ActiveRecord::Base
  belongs_to :project
  validates :gross, presence: true
  validates :date, presence: true

  def self.search(search)
    # @user = User.find(session[:user_id])

    if search
      @sale = Sale.where("date LIKE ?", "%#{search}%")
    else
      @sale = Sale.all
    end
  end
end
# @sale = Sale.where(project_id: Project.where(user_id: @user.id)).limit(50)
@sale = Sale.joins(:project).where("date LIKE ? OR name LIKE ?", "%#{:search}%", "%#{:search}%")
