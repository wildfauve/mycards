class Envsetting
  
  @@set = nil

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
  
  def self.settings
    Rails.logger.info(">>>Envsetting>>SETTINGS: #{@@set.inspect}")        
    @@set = @@set || self.where(:environment => Rails.env).first
    
  end
  
  def self.load_settings(env)
    set = self.where(:environment => env).first
    set
  end
  
  def create_setting(params)
    self.settings << Setting.create_it(params)
    save!
    self    
  end

  def update_setting(params)
    set = self.settings.find(params[:id])
    set.attributes = params[:setting] 
    save!
    self    
  end
  
  def delete_setting(id)
    set = self.settings.find(id)
    set.destroy
    self
  end
  
  def method_missing(meth, *args, &block)
    # TODO only deals with boolean, and doesn't create a method to call instead of method missing
    set = self.settings.where(:name => meth.to_s).first
    if set
      case set.value
      when "yes"
        true
      when "no"
        false
      else
        set.value.to_i
      end
    else
      super
    end
  end
  
end
