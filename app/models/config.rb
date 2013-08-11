class Config

  include Mongoid::Document
  include Mongoid::Timestamps  
  
  embeds_many :settings
  
  field :environment, type: String
  
end
