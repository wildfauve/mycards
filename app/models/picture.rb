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

  def self.get_card_image(args)
    if args[:random]
      pics = self.where(:card_id => args[:card].id)
      return nil if pics.count == 0
      pic = pics[rand(0..pics.size-1)]
    else
      pic = args[:picture]
    end
    # need to resolve the nil card_image problem
    if pic.card_image.nil?
      # need to delete the picture with the nil card_image
      pic.destroy
      return nil
    end
    case args[:size]
    when :thumbnail
      return pic.card_image.thumb(Mycards::Application.config.thumbsize).url
    else
      return pic.card_image.thumb(Mycards::Application.config.thumbsize).url
    end
  end

  private

  def update_pic_attributes
    if image.present? && image_changed?
      self.content_type = image.file.content_type
      self.file_size = image.file.size
    end
  end

end