class SalesChannel < ActiveRecord::Base
  belongs_to :user
  has_many :sales
  validates :name, presence: true

  def self.search(q, user_id)
    SalesChannel.where("user_id = ? AND name LIKE ? OR description LIKE ?", user_id, q, q).uniq
  end
end
