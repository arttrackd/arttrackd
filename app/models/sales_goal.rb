class SalesGoal < ActiveRecord::Base
  belongs_to :user
  validates :amount, presence: true
  validates :length_of_time, presence: true
  validates :start_time, presence: true

  def success # We're going to need to pass success a length of time and use that instead of sales_goals.all
    if @user.projects.sales.sum('gross') >= @user.sales_goals.all.sum('amount')
      success = true
      @user.save
    else
      success = false
      @user.save
    end
  end

end
