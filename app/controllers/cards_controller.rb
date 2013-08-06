class CardsController < ApplicationController

  # GET /cards
  # GET /cards.json
  def index
    @cards = Card.search(params)
    respond_to do |format|
      format.html {render 'home/index' }
      format.js 
    end
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    @card = Card.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /cards/new
  # GET /cards/new.json
  def new
    @card = Card.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /cards/1/edit
  def edit
    @card = Card.find(params[:id])
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.create_card(params[:card])
    Rails.logger.info(">>>card Controller>>CREATE: #{params.inspect}, #{@card.errors.inspect}")    
    respond_to do |format|
      if @card.errors.blank?
        format.html { redirect_to card_path(@card) }
        format.js
        format.json
      else
        build_flash_errors(@card)        
        format.html { render action: "new" }
        format.js { render "create_errors" }
        format.json
      end
    end
  end

  # PUT /cards/1
  # PUT /cards/1.json
  def update
    @card = Card.find(params[:id])
    #Rails.logger.info(">>>card Controller>>UPDATE: #{params.inspect}")

    respond_to do |format|
      if @card.update_attributes(params[:card])
        format.html { redirect_to root_url}
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url }
      format.js
    end
  end

  # get cards/counters
  def counters
    @card_counter = Card.current_card_ct
  end

  private
  
  def date_helper(dates)
    selected_year = dates["date_made(1i)"].to_i
    selected_month = dates["date_made(2i)"].to_i
    selected_day = dates["date_made(3i)"].to_i
    #Rails.logger.info(">>>Card Controller>>Helper: #{selected_year}-#{selected_month}-#{selected_day}")
    Date.new(selected_year, selected_month, selected_day)
    
    #rescue ArgumentError
    #  @card.errors.add(:date, 'is an invalid date')
    #  # Clear the birthdate, so it doesn't show the rolled-over date in the view.
    #  @user.birthdate = nil
    #  render :action => 'new'
    #end
    
  end
  
  
end
