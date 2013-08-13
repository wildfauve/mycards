class SettingsController < ApplicationController
  
  def index
    @config = Envsetting.find(params[:envsetting_id])
  end
  
  def show
  end
  
  def new
    @config = Envsetting.find(params[:envsetting_id])
    @setting = Setting.new
  end
  
  def create
    @config = Envsetting.find(params[:envsetting_id]).create_setting(params[:setting])
    respond_to do |format|
      if @config.errors.blank?
        format.html { redirect_to envsetting_settings_path(@config) }
      else
        build_flash_errors(@config)        
        format.html { render action: "new" }
      end
    end    
  end
  
  def edit
    @config = Envsetting.find(params[:envsetting_id])
    @setting = @config.settings.find(params[:id])  
  end
  
  def update
    @config = Envsetting.find(params[:envsetting_id]).update_setting(params)
    respond_to do |format|
      if @config.errors.blank?
        format.html { redirect_to envsetting_settings_path(@config) }
      else
        build_flash_errors(@config)        
        format.html { render action: "new" }
      end
    end    
    
  end
  
  def destroy
    @config = Envsetting.find(params[:envsetting_id]).delete_setting(params[:id])
    respond_to do |format|
      format.html { redirect_to envsettings_settings_path(@config) }
    end
  end
end