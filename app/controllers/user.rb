class User
    attr_reader :userValid, :userName, :userEmail, :userNickname

    def initialize(id)
        client = Savon::Client.new(wsdl: "http://35.238.81.164:5003/wsusers/wsdl")
        response = client.call :check_user, message: { "userId" => id }
        if response.success?
            data = response.body[:check_user_response]
            if data
                @userValid = data[:userValid] 
                @userName = data[:userName]
                @userEmail = data[:userEmail]
                @userNickname = data[:userNickname]
            end
        end
    end
end