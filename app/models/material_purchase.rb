class MaterialPurchase < ActiveRecord::Base
  belongs_to :user
  has_many :material_uses
  validates :name, presence: true
  validates :cost, presence: true
  validates :units, presence: true

  def self.search(q, user_id)
    MaterialPurchase.where("user_id = ? AND name LIKE ? OR description LIKE ?", user_id, q, q,).uniq
  end
end
