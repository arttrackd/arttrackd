class SalesGoal < ActiveRecord::Base
  belongs_to :user
  validates :amount, presence: true
  validates :length_of_time, presence: true
  validates :start_time, presence: true

  def self.update_goals(user_id)
    goals = SalesGoal.where('user_id = ?', user_id)
    sales = Sale.joins(:project).where('projects.user_id' => user_id)
    goals.each do |goal|
      #Finds all sales within the sales goal start/end dates
      start_date = goal.start_time
      end_date = goal.end_time

      applicable_sales = sales.select{|sale| sale.date.between?(start_date, end_date)}

      if applicable_sales.count > 0
        success = goal.success

        sum_of_sales = applicable_sales.map{|sale| sale.gross}.reduce(:+)
        goal.success = sum_of_sales >= goal.amount

        goal.save unless success == goal.success
      end
    end
  end
end
