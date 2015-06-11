class PagesController < ApplicationController
  def algorithm
    session[:sort_array] = []
  end
  
  #Returns json: pages\fibonacci?number=
  def fibonacci
    number = params[:number].to_i
    render :json => fibonacci_calculate(number)
  end
  
  def sort_array
    #Save to session instead of global variables for multi-user
    ar = session[:sort_array]
    input_character = params[:input_character]
    
    if input_character!="c"
      ar << input_character
      ar = ar.sort_by(&:to_i)
    else
      ar = []
      session[:sort_array] = []
    end
    
    render :json => ar
  end
  
  private
  def fibonacci_calculate(n)
    case n
    when 0, 1, 2
      1
    else
      fibonacci_calculate(n-1) + fibonacci_calculate(n-2)
    end
  end
  
  #helper_method :Fibonacci
end
