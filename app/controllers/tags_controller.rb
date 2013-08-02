class TagsController < ApplicationController

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.search(params)
    @tag = Tag.new
    respond_to do |format|
      format.html
      format.json
    end
  end

  #using this to return, for a given tag, the cards that it exists in
  def show
    @tag = Tag.find(params[:id])
    
  end
  
  def create
    @tag = Tag.create(params[:tag])
    respond_to do |format|
      if @tag.valid?
        format.html { redirect_to tags_path }
        format.json { render :status => :created, :location => tag_path(@tag)}
        # format.js 
      else
        Rails.logger.info(">>>Tags Controller>>Create: #{@tag.errors.inspect}")
        build_flash_errors(@tag)
        format.html { redirect_to  tags_path }
        format.json {render :status => :bad_request}
      end
    end
    
  end
  
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to tags_url }
      # format.js
    end
    
  end
    
  
  def tag_cloud
#    @tag_cloud = Tag.cloud_map
    @tag_cloud = Tag.to_histogram
    respond_to do |format|
      format.json 
    end  
  end
  
  def query
    rex = Regexp.new(params[:q].downcase)
    @tags = Tag.where(:token => rex)
    #Rails.logger.info(">>>Tags Controller>>Index: #{@tags.count}")
    respond_to do |format|
      format.json { render :json => @tags.map(&:token_map) }
    end
  end
  
end