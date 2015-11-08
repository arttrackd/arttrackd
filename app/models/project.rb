class Project < ActiveRecord::Base
  belongs_to :user
  has_many :time_entries
  has_many :sales
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
    user.hourly_rate * total_time/360
  end

  def self.search(p, q)
    @projects = p.where("name LIKE ?", q)
    @projects += p.where("description LIKE ?", q)
    @projects.uniq!
  end
end
