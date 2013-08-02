class PicturesController < ApplicationController

  respond_to :html, :json
  # GET /pictures
  # GET /pictures.json
  def index
    #Rails.logger.info(">>>ADMIN::picture Controller>>Index: #{Mycards::Application.config.thumbsize}")
    @card = Card.find(params[:card_id])
    @picture = Picture.new
    respond_with do |format|
      format.html # new.html.erb
    end
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @card_id = params[:card_id]
    @picture = Picture.find(params[:id])
    respond_with do |format|
      format.html # show.html.erb
    end
  end

  # GET /pictures/new
  # GET /pictures/new.json
  def new
    @card = Card.find(params[:card_id])
    @picture = Picture.new

    respond_with do |format|
      format.html # new.html.erb
    end
  end

  # GET /pictures/1/edit
  def edit
    @picture = Picture.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @card = Card.find(params[:card_id])
    @picture = Picture.new(params[:picture])
    @card.pictures << @picture

    respond_with do |format|
      if @picture.save
        format.html { redirect_to card_path(@card) }
      else
        Rails.logger.info(">>>Picture Controller>>Create Error: #{@picture.errors.inspect}")
        format.html { render action: "new" }
      end
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update
    @picture = Picture.find(params[:id])
    respond_with do |format|
      if @picture.update_attributes(params[:picture])
        format.html { redirect_to picture_path(@picture), notice: 'Picture was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy

    respond_with do |format|
      format.html { redirect_to card_pictures_url }
      format.js
    end
  end
    
end
