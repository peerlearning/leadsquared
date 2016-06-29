module Leadsquared
  class ApiConnection
    attr_reader :connection

    def initialize(service)
      @connection = Leadsquared::Client.new
      @service = service
    end

    protected

    def url_with_service(action)
      @service + action
    end

    def handle_response(response)
      case response.status
      when 200..499
        return JSON.parse response.body
      when 500
        message = response.body #.try(:[],  "ExceptionMessage")
        raise InvalidRequestError.new("Internal Error: #{message}")
      else
        raise InvalidRequestError.new("Unknown Error#{response.body}")
      end
    end
  end
end
