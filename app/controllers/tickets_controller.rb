class TicketsController < ApplicationController
  def new
    @ticket = Ticket.new
    @ticket_categories = TicketCategory.new
    #@categories = Category.find(:all)
  end
  
  def index
    @tickets = Ticket.all
    @ticket = Ticket.new
  end
  
  def create
    @ticket = Ticket.new(params[:ticket].to_hash)
    @ticket.user_id = current_user.id
      if @ticket.save
      #  params[:category_ids].each do |k,v|
      #    @ticket.categories << Category.find(k)
      #  end
      update_category_param
      
        flash[:notice] = 'Ticket was successfully created.'
        redirect_to :action => 'index'
      else
        redirect_to :action => 'index'
      end
  end
  
  def edit
    @ticket = Ticket.find(params[:id])
    render layout: false
  end
  
  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(params[:ticket].to_hash)
      @ticket.categories.destroy_all
      update_category_param
      flash[:notice] = 'Ticket was successfully updated.'
      redirect_to :action => 'index'
    else
      render 'edit'
      #flash ...
    end
  end
  
  def update_category_param
    params[:category_ids].each do |k,v|
          @ticket.categories << Category.find(k)
        end
  end
end
