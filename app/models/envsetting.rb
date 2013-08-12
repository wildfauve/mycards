class Envsetting

  include Mongoid::Document
  include Mongoid::Timestamps  
  
  embeds_many :settings
  
  field :environment, type: String
  
  def self.create_it(params)
    env = self.new(params)
    if env.errors.blank? 
      env.save!
      env
    else
      env
    end
  end
  
  def create_setting(params)
    self.settings << Setting.create_it(params)
    save!
    self    
  end
  
end
