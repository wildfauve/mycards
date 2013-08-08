class Card

  @@per_page = 10
  
  include Mongoid::Document
  include Mongoid::Timestamps  
    
  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  tire.mapping do
    indexes :id, :index => :not_analysed
    indexes :decription, :index => 'snowball', :boost => 100
    indexes :ref_id, :index => :not_analysed
    indexes :date_made, :type => 'date', :index => 'standard'
    indexes :cents_price, :type => 'integer'
    indexes :tags do
      indexes :tag, :index => :keyword
    end
    indexes :customers do
      indexes :customer, :index => :keyword
    end
  end
  
  before_create :create_index
  after_save :modify_total_sold
  
  validates_presence_of :date_made, :message => "You need to include a date made"
  #validates :date_made, :presence => true, :date_format => true

  attr_reader :card_tags, :card_custs
  
  field :ref_id, :type => Integer
  field :description, :type => String
  field :date_made, :type => Date, :default => Date.today
  field :date_sold, :type => Date
  field :cents_price, :type => Integer, :default => 0
  field :no_charge, :type => Boolean, :default => false
  
  # Note, without the dependent: :delete/:destroy a picture will remain orphened after card delete.
  has_many :pictures
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :customers

  def self.create_card(params)
    card = self.new(params)
    if card.errors.blank? 
      card.save!
      card
    else
      raise
      card
    end
  end

  def self.total_made(date)
    self.where(:date_made => date).count
  end

  def delete_card
    self.destroy
  end

  def card_tags=(tag_ids)
    tags_list = tag_ids.split(",")
    self.tag_ids = tags_list
  end

  def card_custs=(customer_ids)
    Rails.logger.info(">>>CARD Custs #{customer_ids}, #{self.date_sold}")
    unless self.date_sold
      self.date_sold = Date.today unless !customer_ids.empty? 
    end
    custs_list = customer_ids.split(",")
    self.customer_ids = custs_list
  end


  def card_price(options = {})
    raise ArgumentError, 'The "options" arg must be a Hash' unless options.is_a? Hash
    options[:in] ||= 'NZD'
    self.cents_price.nil? ? cents = 0 : cents = self.cents_price
    Money.new(cents, options[:in])
  end

  def card_price=(new_price)
    # Implement a TEST card --price starts with "#T"
    if new_price.match /^#T/  # it is a test message
      @test_card = true
      new_price = "0.00"
    end
    if /^[\d]+(\.[\d]+){0,1}$/ === new_price.gsub(/\$/, "")
      new_price = Money.parse(new_price, "NZD")
      if [Fixnum, Money].include? new_price.class
        new_price = new_price.cents if new_price.is_a? Money
        self.cents_price = new_price
      else
        errors.add(:card_price, "Card Price is not a Money value")        
      end
    else
      errors.add(:card_price, "Card Price does not appear to be a number") unless /^[\d]+(\.[\d]+){0,1}$/ === new_price.gsub(/\$/, "")
    end
  end
    
  def self.total_sales
    Rails.logger.info(">>>CARDS MODEL>>TOTAL SALES CALLED")
    sales = Counter.where(:count_type => "total_sales")
    sales.empty? ? Money.new(0, "NZD") : Money.new(sales.first.ct, "NZD") 
  end
  
  def self.current_card_ct 
    c = Counter.where(:count_type => "card").first
    c.nil? ? 0 : c.ct
  end

  def self.search(params)
    page = params[:page] || "1"
    Rails.logger.info(">>>CARDS MODEL SEARCH #{page}")
    doc_from = ((page.to_i - 1) * @@per_page)
    if params[:search].present?  # param entered from the search box
      params[:src].present? ? qstring = params[:src] + ":" + params[:search] : qstring = params[:search] 
      r = tire.search do
        query {string qstring }
        from doc_from
        size @@per_page
      end
      Rails.logger.info(">>>CARDS MODEL>>#{qstring} #{r.inspect}")
    else
      order_by = :date_made
      order_by = :ref_id if params[:order].present? && params[:order] == "sequence"
      r = self.all.desc(order_by).page(params[:page])      
    end
    r
  end

  def to_indexed_json
      { :id => id,
        :description => description,
        :ref_id => ref_id,
        :date_made => date_made,
        :cents_price => cents_price,
        :tags => tags.map {|t| t.token },
        :customers => customers.map {|t| t.name }
      }.to_json
  end
    
  def total_made_on_this_date
    Card.where(:date_made => self.date_made).size
  end  
  
  private
  
  def self.calc_total_sales
    cards = Card.where(:date_sold.exists => true, :no_charge.ne => true)
    cards.reduce(Money.new(0, "NZD")) {|result, c| result + c.card_price}
  end

  
  
  def create_index
    @test_card ? self.ref_id = 0 : self.ref_id = Integer(Counter.increment("card"))
  end

  def modify_total_sold
    Counter.store_or_create(:total_sales, Card.calc_total_sales.cents)
  end
  
  def modify_counts
    Counter.increment("card")
  end
  
  # These Mongo guys sure do get funky with their IDs in +serializable_hash+, let's fix it.
  #
  
  def self.data_for(type)
    if type == 'count'
      cards = self.count_on_id
    elsif type == 'time'
      cards = self.date_histogram
    else
      nil
    end
  end

  def self.date_histogram(period='week')
    s = tire.search do
      facet("made_date") {date :date_made, :interval => period}
      size 10
    end
    return s.facets
  end
  
end