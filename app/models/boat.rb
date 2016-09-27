class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


  def self.first_five
    self.limit(5)
  end

  def self.dinghy
    # self.where()

    self.where("length < 20")
  end

  def self.ship
    self.where("length > 20")
  end

  def self.last_three_alphabetically
    self.limit(3).order("name desc")
  end

  def self.without_a_captain
    self.where(captain_id: nil)
  end

  def self.sailboats
    # binding.pry
    self.joins(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.with_three_classifications
    self.joins(:classifications).group(:boat_id).having('count(*)= ?', 3)
  end

end
