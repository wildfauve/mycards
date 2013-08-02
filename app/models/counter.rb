class Counter
  include Mongoid::Document

  field :ct, :type => Integer
  field :count_type, :type => String

  def self.increment(ct_type)
    count = Counter.where(:count_type => ct_type)
    if count.empty?
      count = Counter.create(:count_type => ct_type, :ct => 0)
    else
      count = count.first
    end
    return count.inc(:ct, 1)
  end 

  def self.store_or_create(type, value)
    #Rails.logger.info(">>>Count>>Store or Create: #{type} #{value}")
    counter = Counter.where(:count_type => type).first
    if counter.nil?
      Counter.create(:count_type => type, :ct => value)
    else
      counter.ct = value
      counter.save!
    end
  end
    
end