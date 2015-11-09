class Sale < ActiveRecord::Base
  belongs_to :project
  belongs_to :sales_channel
  validates :gross, presence: true
  validates :date, presence: true


  def self.search(q, user_id)
    Sale.joins(:project).where("user_id = ? AND date LIKE ? OR name LIKE ? ", user_id, q, q).uniq
  end
end
