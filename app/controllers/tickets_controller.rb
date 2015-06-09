class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all
    @ticket = Ticket.new
    
    totalTicketNumber = Ticket.all.count
    totalCurrentUserTicket = Ticket.where(:user_id => current_user.id).count
    @chart = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({:defaultSeriesType=>"pie", :backgroundColor=>'rgba(255, 255, 255, 0.1)'} )
      series = {
               :type=> 'pie',
               :name=> 'Browser share',
               :data=> [
                  {
                     :name=> 'No tickets created by you',    
                     #:y=> 12.8,
                     :y=> totalCurrentUserTicket.to_f / totalTicketNumber.to_f * 100.0,
                     :sliced=> true,
                     :selected=> true
                  },
                  ['Others', (totalTicketNumber - totalCurrentUserTicket).to_f / totalTicketNumber.to_f * 100]
               ]
      }
      f.series(series)
      f.options[:title][:text] = "Ur tickets / Total Tickets"
      f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto'}) 
      f.plot_options(:pie=>{
        :allowPointSelect=>true, 
        :cursor=>"pointer" , 
        :dataLabels=>{
          :enabled=>true,
          :color=>"black",
          :style=>{
            :font=>"13px Trebuchet MS, Verdana, sans-serif"
          }
        }
      })
    end
    @trendchart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Ticket Trending Of Last 5 Days")
      f.xAxis(:categories => [4.day.ago.to_date, 3.day.ago.to_date, 2.day.ago.to_date, 1.day.ago.to_date, DateTime.now.to_date])
      f.series(:name => "Number of tickets", :yAxis => 1, :data => [Ticket.where("created_at > ? AND created_at < ?", 5.day.ago, 4.day.ago).count,
        Ticket.where("created_at > ? AND created_at < ?", 4.day.ago, 3.day.ago).count,
        Ticket.where("created_at > ? AND created_at < ?", 3.day.ago, 2.day.ago).count,
        Ticket.where("created_at > ? AND created_at < ?", 2.day.ago, 1.day.ago).count,
        Ticket.where("created_at > ? AND created_at < ?", 1.day.ago, Time.now).count])
    
      f.yAxis [
        {:title => {:text => ""} },
        {:title => {:text => "Number of tickets"}, :opposite => true},
      ]
    
      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"line", :backgroundColor=>'rgba(255, 255, 255, 0.1)'})
    end
  end
  
  def new
    @ticket = Ticket.new
    @ticket_categories = TicketCategory.new
    #@categories = Category.find(:all)
  end
  
  
  def create
    ##Declaration
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
