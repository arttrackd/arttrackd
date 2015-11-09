class BusinessExpense < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :amount, presence: true

  def self.search(q)
    search =  "%#{q}%"
    BusinessExpense.where('name LIKE ? OR description LIKE ?', search, search)
  end
end
