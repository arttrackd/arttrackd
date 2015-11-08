class MaterialUse < ActiveRecord::Base
  belongs_to :material_purchase
  belongs_to :project
  validates :name, presence: true
  validates :units, presence: true

  def self.search(mu, q)
    @material_uses = mu.where("name LIKE ?", q)
  end
end
