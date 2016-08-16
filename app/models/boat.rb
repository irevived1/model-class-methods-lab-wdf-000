class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    select("*").limit(5)
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length >= 20")
  end

  def self.last_three_alphabetically
    order("name DESC").limit(3)
  end

  def self.without_a_captain
    where("captain_id IS NULL")
  end

  def self.sailboats
    Boat.joins(:classifications).where("classifications.name == 'Sailboat'")
  end

  def self.with_three_classifications
    # sql =  "select * from boats JOIN boat_classifications ON boat_classifications.boat_id == boats.id
# JOIN classifications ON boat_classifications.classification_id == classifications.id GROUP BY boats.name HAVING COUNT(*) == 3;"
    # find_by_sql(sql)
    select("boats.*").joins(:classifications).group("boats.name").having("COUNT(*) = 3")
  end
end
