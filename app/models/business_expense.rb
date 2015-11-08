class BusinessExpense < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :amount, presence: true

  def self.search(be, q)
    @business_expense = be.where("name LIKE ?", q)
    @business_expense += be.where('description LIKE ?', q)
    @business_expense.uniq!
  end
end
