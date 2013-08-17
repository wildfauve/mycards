class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :main_var_load, :only => [:new, :show, :index, :edit, :new, :filter]
  
  def main_var_load
    @card = Card.new
    @counter = Card.current_card_ct
    @total_sales = Card.total_sales
  end
    
  def build_flash_errors(model)
    if model.errors.any?
      flash[:errors] = model.errors.messages
    end
  end
  
end
