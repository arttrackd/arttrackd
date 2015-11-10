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

  def total_material_cost(project)
    total_units = 0
    total_cost = 0
    project.user.material_purchases
     total_units = total_units + x.material_purchase.units
     total_cost =  total_cost + x.material_purchase.cost
     total = total_cost * total_units
  end

  def self.search(q)
    search =  "%#{q}%"
    Project.where("projects.name LIKE ? OR projects.description LIKE ?", search, search)
  end
end
