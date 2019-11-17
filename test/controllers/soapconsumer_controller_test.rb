require 'test_helper'

class SoapconsumerControllerTest < ActionDispatch::IntegrationTest
  test "should get respuesta" do
    get soapconsumer_respuesta_url
    assert_response :success
  end

end
