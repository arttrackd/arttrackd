class MaterialPurchase < ActiveRecord::Base
  belongs_to :user
  has_many :material_uses
  has_attached_file :receipt, styles: { thumb: "100x100>" }
  validates_attachment_content_type :receipt, content_type: /\Aimage\/.*\Z/
  validates :name, presence: true
  validates :cost, presence: true
  validates :units, presence: true

  def update_stock
    total_units_used = MaterialUse.where(material_purchase_id: id).pluck(:units).sum
    units - total_units_used
  end

  def self.search(q)
    q = "%#{q}%"
    MaterialPurchase.where("name LIKE LOWER(?)", q).order(:name)
  end
end
