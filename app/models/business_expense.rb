class BusinessExpense < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :amount, presence: true

  def self.search(search)
    if search
      @business_expense = BusinessExpense.where("name LIKE ?", "%#{search}%")
    end
  end
end
