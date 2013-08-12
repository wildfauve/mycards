class Setting

  include Mongoid::Document
  include Mongoid::Timestamps  
  
  embedded_in :settings, inverse_of: :settings
  
  field :name, type: String
  field :value, type: String
  
  def self.create_it(params)
    set = self.new(params)
    set
  end
  
end
