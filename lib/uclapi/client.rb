require 'net/https'
require 'json'

module UCLAPI
  class Client
    class ServerError < StandardError; end
    class NotFoundError < StandardError; end
    class BadRequestError < StandardError; end
    class UnauthorizedError < StandardError; end

    ENDPOINT = 'uclapi.com'.freeze

    attr_accessor :token, :http, :debug

    def initialize(options = {})
      @token = options.fetch(:token) do
        ENV['UCLAPI_TOKEN'] || raise(KeyError, "Missing required argument: token")
      end

      @debug = options.fetch(:debug) do
        ENV['UCLAPI_DEBUG']
      end

      @http = Net::HTTP.new(ENDPOINT, Net::HTTP.https_default_port)
      http.use_ssl = true

      http.set_debug_output $stderr if debug
    end

    def roombookings
      UCLAPI::Client::Roombookings.new(self)
    end

    def get(path, params = {})
      uri = uri_for(path, params)
      message = Net::HTTP::Get.new(uri.request_uri)
      transmit(message)
    end

    private

    def uri_for(path, params = {})
      uri = URI("https://#{ENDPOINT}#{path}")
      uri.query = URI.encode_www_form(params.merge({
        token: token
      }))
      uri
    end

    def transmit(message)
      parse(http.request(message))
    end

    def parse response
      data = json?(response) ? JSON.parse(response.body) : response.body

      case response
      when Net::HTTPSuccess
        data
      when Net::HTTPNotFound
        raise NotFoundError, "Record not found (404)"
      when Net::HTTPBadRequest
        raise BadRequestError, data
      when Net::HTTPUnauthorized
        raise UnauthorizedError, "Access Denied (401)"
      else
        if json?(response)
          raise ServerError, "HTTP #{response.code}: #{JSON.parse(response.body)}"
        else
          raise ServerError, "HTTP #{response.code}: #{response.body}"
        end
      end
    end

    def json?(response)
      content_type = response['Content-Type']
      json_header = content_type && content_type.split(';').first == 'application/json'
      has_body = response.body && response.body.length > 0
      json_header && has_body
    end
  end
end
