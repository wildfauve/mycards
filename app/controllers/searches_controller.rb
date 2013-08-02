class SearchesController < ApplicationController

	def index
	  @cards = Card.search(params)
	end

end
