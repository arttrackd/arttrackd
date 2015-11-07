class Project < ActiveRecord::Base
  belongs_to :user
  has_many :time_entries
  has_many :sales
  has_many :material_uses
  validates :name, presence: true
  accepts_nested_attributes_for :material_uses, reject_if: :all_blank, allow_destroy: :true


  def total_time
    # Set a default value for time entry total_time field later
    time_entries.reduce(0.0){|sum, t| sum + (t.total_time || 0)}
  end

  def estimated_value
    user.hourly_rate * total_time/360
  end

  def self.search(search)
    if search
      @projects = Project.where("name LIKE ?", "%#{search}%")
    end
  end
end
