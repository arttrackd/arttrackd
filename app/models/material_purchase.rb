class MaterialPurchase < ActiveRecord::Base
  belongs_to :user
  has_many :material_uses
  validates :name, presence: true
  validates :cost, presence: true
  validates :units, presence: true

  def self.search(q)
    q = "%#{q}%"
    MaterialPurchase.where("name LIKE LOWER(?) OR description LIKE LOWER(?)", q, q,).uniq.order(:name)
  end
end
