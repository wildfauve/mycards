module CardsHelper
  def picture_for(card_id)    
    pic = Picture.random_for_card(card_id)
    image_tag(pic, :border => 0) if !pic.nil?
  end  
    
end
