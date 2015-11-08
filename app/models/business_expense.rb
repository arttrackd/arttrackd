class BusinessExpense < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :amount, presence: true

  def self.search(be, q)
    @business_expense = be.where("name LIKE ?", q)
  end
end
