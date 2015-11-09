class BusinessExpense < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :amount, presence: true

  def self.search(q, user_id)
    BusinessExpense.where("user_id = ? AND name LIKE ? OR description LIKE ?", user_id, q, q).uniq
  end
end
