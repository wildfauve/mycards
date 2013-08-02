class CustomersController < ApplicationController

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.search(params)
    @customer = Customer.new
    @filter = params[:filter] if params[:filter]
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  def create
    @customer = Customer.create(params[:customer])
    Rails.logger.info(">>>Card Controller>>Create Valid?: #{@customer.valid?}, #{@customer.inspect} ")
    respond_to do |format|
      if @customer.valid?
        format.html { redirect_to customers_path }
        format.json { render :status => :created, :location => customer_path(@customer)}
        # format.js 
      else
        # TODO: Cant get the errors displayed in the HTML view...
        format.html { redirect_to customers_path }
        format.json {render :status => :bad_request}
      end
    end
    
  end
  
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url }
      # format.js
    end
    
  end
    
  
  def customer_cloud
    respond_to do |format|
      format.json { render :json => Customer.cloud_map }
    end  
  end
  
  def query
    rex = Regexp.new(params[:q])
    @customers = Customer.where(:name => rex)
    Rails.logger.info(">>>Customers Controller>>Index: #{@customers.count}")
    respond_to do |format|
      format.json { render :json => @customers.map(&:name_map) }
    end
  end  
  
  def filter
    redirect_to customers_path({:filter => params['customer']['name']}) 
  end
    
end
