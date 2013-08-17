module CardsHelper
  
  # :card => Card object, :picture => Picture object, :size => :thumbnail/
  def picture_for(args)    
    pic = Picture.get_card_image(args)
    image_tag(pic, :border => 0) if !pic.nil?
  end  
    
end
