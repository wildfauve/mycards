class Picture
  include Mongoid::Document
  include Mongoid::Timestamps    
#  attr_accessible :image, :image_cache
  field :card_image_uid
  image_accessor :card_image

  
#  field :content_type
#  field :file_size
  
  belongs_to :card
  
#  before_save :update_pic_attributes

  def self.random_for_card(card_id)
    pics = self.where(:card_id => card_id)
    return pics[rand(0..pics.size-1)].card_image.thumb(Mycards::Application.config.thumbsize).url if !pics.empty?
  end

  private

  def update_pic_attributes
    if image.present? && image_changed?
      self.content_type = image.file.content_type
      self.file_size = image.file.size
    end
  end

end