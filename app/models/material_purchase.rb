class MaterialPurchase < ActiveRecord::Base
  belongs_to :user
  has_many :material_uses
  validates :name, presence: true
  validates :cost, presence: true
  validates :units, presence: true

  def self.search(search)
    if search
      @material_purchases = MaterialPurchase.where("name LIKE ?", "%#{search}%")
    end
  end
end
