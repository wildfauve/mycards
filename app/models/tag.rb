class Tag
  include Mongoid::Document
  
  validates_uniqueness_of :token, :message => "You can't have the same token name"
  
  field :token, :type => String
  
  has_and_belongs_to_many :cards
  
  
  def token=(token)
    write_attribute(:token, token.downcase)
  end
  
  def self.tag_cloud
    self.all.keep_if {|t| t.frequency > 0}
  end
  
  def self.cloud_map
    
#    Tag.all.inject([]) do |set, elem|
#      if elem.frequency > 0
#        h = {}
#        h[:text] = elem.token
#        h[:weight] = elem.frequency
#        h["link"] = "/search?search=tags:#{elem.token}"
#        set << h
#      else
#        set
#      end
#    end
  end
  
  def self.to_histogram
    t = Tag.all.inject([]) do |set, t| 
      set << {:token => t.token,  :freq => t.frequency} if t.frequency > 0
      set
    end
    limited = t.sort_by{|k| k[:freq]}
    limited[limited.length-20..limited.length] if limited.length > 20
  end

  def token_map
    { :id => _id, :name => token }
  end

  def frequency
    #note: If use self.cards.size, it does a Mongo read to get the cards before calling size.
    self.card_ids.size
  end
  
  #probably should be a map/reduce operation in the database
  def self.top_5
    tags = Tag.where(:card_ids.exists => true).to_a
          .keep_if {|t| !:card_ids.empty?}
          .sort { |a, b| b.frequency <=> a.frequency }
    tags.slice!(5..tags.size-1)    
    return tags
  end
  
  def self.search(params)
    if params[:search].present?
      self.where(:token=> params[:search])
    else
      self.all.order_by([:token, :asc]).page(params[:page])
    end
  end
  
  
  
  private
  
end
