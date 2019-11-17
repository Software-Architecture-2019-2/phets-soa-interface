class SoapconsumerController < ApplicationController
  
  def index

  end
  
  def respuesta
    id = "#{params[:id]}"
    
    @user = User.new(id)
  end
end
