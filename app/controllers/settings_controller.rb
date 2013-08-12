class SettingsController < ApplicationController
  
  def index
    @config = Envsetting.find(params[:config_id])
  end
  
  def show
  end
  
  def new
    @config = Envsetting.find(params[:config_id])
    @setting = Setting.new
  end
  
  def create
    @config = Envsetting.find(params[:config_id]).create_setting(params[:setting])
    respond_to do |format|
      if @config.errors.blank?
        format.html { redirect_to config_settings_path(@config) }
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