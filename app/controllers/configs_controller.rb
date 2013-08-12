class ConfigsController < ApplicationController
  
  def index
    @configs = Envsetting.all
  end
  
  def show
  end
  
  def new
    @config = Envsetting.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def create
    @config = Envsetting.create_it(params[:envsetting])
    respond_to do |format|
      if @config.errors.blank?
        format.html { redirect_to configs_path }
        format.js
        format.json
      else
        build_flash_errors(@config)        
        format.html { render action: "new" }
        format.js { render "create_errors" }
        format.json
      end
    end
  end
  
  def edit
  end
  
  def update
  end
end