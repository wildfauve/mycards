class ChartsController < ApplicationController

  def index
  end
  
  def show
    @data = Card.data_for(params[:id])
    respond_to do |format|
      format.json  
    end
  end
end