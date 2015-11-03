class Sale < ActiveRecord::Base
  belongs_to :project
  validates :gross, presence: true
  validates :date, presence: true
  before_action :net
  
  def net

  end

end
