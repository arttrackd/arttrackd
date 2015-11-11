class MaterialUse < ActiveRecord::Base
  belongs_to :material_purchase
  belongs_to :project
  belongs_to :user

  validates :name, presence: true
  validates :units, presence: true

  def material_in_stock
    materials = MaterialUse.where(user_id: @current_user.id)
    array_units = materials.map{ |x| {x.id =>x.units.to_i}}

  end

  def self.search(mu, q)
    search =  "%#{q}%"
    material_uses_search = Project.where(id: mu.where("name LIKE LOWER(?)", search).pluck(:project_id)).arel.constraints.reduce(:and)
    project_search = Project.search(q).arel.constraints.reduce(:and)
    Project.where(project_search.or(material_uses_search))

    #MaterialUse.where('name LIKE ? OR description LIKE ?', search, search)
  end
end
