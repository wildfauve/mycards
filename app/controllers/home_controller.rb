class HomeController < ApplicationController
  def index
    @cards = Card.search(params)
  end

end
