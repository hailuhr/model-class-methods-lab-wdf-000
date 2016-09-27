class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
    # binding.pry
    self.joins(boats: :classifications).where(:classifications=> {name: "Catamaran"})
  end

  def self.sailors
    self.joins(boats: :classifications).where(:classifications => {name: "Sailboat"}).uniq
  end


  def self.motorboaters
    self.joins(boats: :classifications).where(:classifications => {name: "Motorboat"})
  end


  def self.talented_seamen

    sailors_and_motorboaters = self.sailors & self.motorboaters
    self.where(:id => sailors_and_motorboaters.map(&:id))

  end

  def self.non_sailors
    
    no_sailors = self.all - self.sailors
    self.where(:id => no_sailors.map(&:id))
  end


end
