class SalesChannel < ActiveRecord::Base
  belongs_to :user
  has_many :sales
  validates :name, presence: true

  def self.search(q)
    q = "%#{q}%"
    SalesChannel.where("name LIKE ? OR description LIKE ?", q, q)
  end
end
