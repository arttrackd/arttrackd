class Project < ActiveRecord::Base
  belongs_to :user
  has_many :time_entries
  has_many :sales, dependent: :restrict_with_error
  has_many :material_uses
  has_many :project_costs
  validates :name, presence: true
  accepts_nested_attributes_for :material_uses, reject_if: :all_blank, allow_destroy: :true
  accepts_nested_attributes_for :project_costs, reject_if: :all_blank, allow_destroy: :true

  def total_time
    # Set a default value for time entry total_time field later
    time_entries.reduce(0.0){|sum, t| sum + (t.total_time || 0)}
  end

  def estimated_value
    user.hourly_rate * total_time/3600
  end

  def total_material_cost
    # project = Project.joins(:material_uses).where('material_purchase_id' => material_purchases.id).includes(:material_purchases)
    # project.material_uses.where(material_purchase_id: project.user.material_purchases)

    purchase = material_uses.first.material_purchase
    cost_per_unit = purchase.cost / purchase.units
    total_units = material_uses.first.units
    total = cost_per_unit * total_units
    total
    
  end

  def self.search(q)
    search =  "%#{q}%"
    Project.where("projects.name LIKE ? OR projects.description LIKE ?", search, search)
  end
end
