class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all
    @ticket = Ticket.new
    
    @piechart = piechart_user_ticket_to_total_ticket
    @trendchart = trendchart_last_5_days
  end
  
  def new
    @ticket = Ticket.new
    @ticket_categories = TicketCategory.new
  end
  
  
  def create
    ##Declaration
    @ticket = Ticket.new(params[:ticket].to_hash)
    @ticket.user_id = current_user.id
    
    if @ticket.save
      update_category_param
        flash[:notice] = 'Ticket was successfully created.'
        redirect_to :action => 'index'
      else
        redirect_to :action => 'new'
    end
  end
  
  def edit
    @ticket = Ticket.find(params[:id])
    render layout: false
  end
  
  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(params[:ticket].to_hash)
      #Destroy all categories and recreate
      @ticket.categories.destroy_all
      update_category_param
      flash[:notice] = 'Ticket was successfully updated.'
      redirect_to :action => 'index'
    else
      render 'edit'
      #flash ...
    end
  end
  
  #use to update categories of a ticket (using in both create and update)
  private
  def update_category_param
    params[:category_ids].each do |k,v|
          @ticket.categories << Category.find(k)
        end
  end
  
  private
  def trendchart_last_5_days
    trendvalues = [Ticket.where("created_at > ? AND created_at < ?", 5.day.ago, 4.day.ago).count,
      Ticket.where("created_at > ? AND created_at < ?", 4.day.ago, 3.day.ago).count,
      Ticket.where("created_at > ? AND created_at < ?", 3.day.ago, 2.day.ago).count,
      Ticket.where("created_at > ? AND created_at < ?", 2.day.ago, 1.day.ago).count,
      Ticket.where("created_at > ? AND created_at < ?", 1.day.ago, Time.now).count]
    trendcategories = [4.day.ago.to_date, 3.day.ago.to_date, 2.day.ago.to_date, 1.day.ago.to_date, DateTime.now.to_date]
      
    ChartHelper.generate_graphchart "Ticket Trending Of Last 5 Days", "Number of tickets", "Number of tickets", trendvalues, trendcategories
  end
  
  private
  def piechart_user_ticket_to_total_ticket
    totalTicketNumber = Ticket.all.count
    totalCurrentUserTicket = Ticket.where(:user_id => current_user.id).count
    
    chartvalues = ['No tickets created by you', totalCurrentUserTicket.to_f / totalTicketNumber.to_f * 100.0],
      ['Others', (totalTicketNumber - totalCurrentUserTicket).to_f / totalTicketNumber.to_f * 100]
      
    ChartHelper.generate_piechart "Ur tickets / Total Tickets", chartvalues
  end
end
