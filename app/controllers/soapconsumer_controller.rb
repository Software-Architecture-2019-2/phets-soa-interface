class SoapconsumerController < ApplicationController
  
  def index

  end
  
  def respuesta
    id = "#{params[:id]}"
    client = Savon::Client.new(wsdl: "http://35.238.81.164:5003/wsusers/wsdl")
    response = client.call :check_user, message: { "userId" => id }
    if response.success?
        data = response.body[:check_user_response]
        @user = data
        render :json => data
    end
  end
end
