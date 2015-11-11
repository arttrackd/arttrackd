class MaterialUse < ActiveRecord::Base
  belongs_to :material_purchase
  belongs_to :project
  belongs_to :user

  # validates :name, presence: true
  validates :user,                presence: true
  validates :material_purchase,   presence: true
  validates :units,               presence: true
  validate :enough_in_stock, on: :create

  delegate :name,                 to: :material_purchase
  delegate :description,          to: :material_purchase


  def enough_in_stock
    unless MaterialPurchase.find(material_purchase_id).units_remaining >= self.units
      errors.add(:units, "You do not have that many units in stock")
    end
  end

  def self.search(mu, q)
    search =  "%#{q}%"
    material_uses_search = Project.where(id: mu.where("name LIKE LOWER(?)", search).pluck(:project_id)).arel.constraints.reduce(:and)
    project_search = Project.search(q).arel.constraints.reduce(:and)
    Project.where(project_search.or(material_uses_search))

    #MaterialUse.where('name LIKE ? OR description LIKE ?', search, search)
  end
end
