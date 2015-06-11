class ChartHelper
  def self.generate_graphchart(title, xAsisname, yAxisName, chartvalues, chartcategories)
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => title)
      f.xAxis(:categories => chartcategories)
      f.series(:name => xAsisname, :yAxis => 1, :data => chartvalues)

      f.yAxis [
        {:title => {:text => ""} },
        {:title => {:text => yAxisName}, :opposite => true},
      ]

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"line", :backgroundColor=>'rgba(255, 255, 255, 0.1)'})
    end
  end
  
  def self.generate_piechart(title, chartvalues)
    LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({:defaultSeriesType=>"pie", :backgroundColor=>'rgba(255, 255, 255, 0.1)'} )
      series = {
               :type=> 'pie',
               :data=> chartvalues
      }
      f.series(series)
      f.options[:title][:text] = title
      f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto'}) 
      f.plot_options(:pie=>{
        :allowPointSelect=>true, 
        :cursor=>"pointer" , 
        :dataLabels=>{
          :enabled=>true,
          :color=>"blue",
          :style=>{
            :font=>"13px Trebuchet MS, Verdana, sans-serif"
          }
        }
      })
    end
  end
end