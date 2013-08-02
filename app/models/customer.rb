class Customer
  include Mongoid::Document
  
  field :name, :type => String
  
  validates_uniqueness_of :name, :message => "You can only include the name once", :case_sensitive => false
  
  has_and_belongs_to_many :cards
  
  def name=(value)
    write_attribute(:name, value.downcase)
  end
  
  def name_map
    { :id => _id, :name => name }
  end
  
  def self.search(params)
    if params[:search].present?
      self.where(:name=> params[:search])
    elsif params[:filter].present?
      rex = Regexp.new(params[:filter])
      self.where(:name => rex).page(params[:page])
    else
      self.all.order_by([:name, :asc]).page(params[:page])
    end    
  end
  
    
end