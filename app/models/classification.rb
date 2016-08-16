class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    select("*").distinct
  end

  def self.longest
    joins(:boats).where("boats.length == ? ",self.joins(:boats).maximum('boats.length'))
  end

end
