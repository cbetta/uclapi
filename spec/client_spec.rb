require_relative './test_helper'

describe 'UCLAPI::Client' do
  before do
    @client = UCLAPI::Client.new(token: '123')
  end

  describe '.initialize' do
    it "should return successful with the right params" do
      client = UCLAPI::Client.new(token: '123')
      client.must_be_instance_of UCLAPI::Client
      client.token.must_equal '123'
      client.debug.must_equal false
    end

    it "should return successful with the ENV variables set" do
      ENV['UCLAPI_TOKEN'] = '123'
      ENV['UCLAPI_DEBUG'] = "1"

      client = UCLAPI::Client.new
      client.must_be_instance_of UCLAPI::Client
      client.token.must_equal '123'
      client.debug.must_equal true

      ENV.delete('UCLAPI_TOKEN')
      ENV.delete('UCLAPI_DEBUG')
    end

    it "should raise without the right params" do
      assert_raises KeyError do
        UCLAPI::Client.new
      end
    end
  end

  describe '.roombookings' do
    it "should return a UCLAPI::Client::Roombookings object" do
      @client.roombookings.must_be_instance_of UCLAPI::Client::Roombookings
    end
  end

  describe '.search' do
    it "should return a UCLAPI::Client::Search object" do
      @client.search.must_be_instance_of UCLAPI::Client::Search
    end
  end

  describe '.get' do
    it "should return the json on success" do
      stub_request(:get, "https://uclapi.com/foo/bar?token=123").
        to_return(:status => 200, :body => '{"ok":"true","records":[{"id":4,"name":"foo bar"}]}', :headers => { 'Content-Type' =>  'application/json'})

      result = @client.get('/foo/bar')
      result['records'].first['id'].must_equal 4
    end

    it "should raise on 401" do
      stub_request(:get, "https://uclapi.com/foo/bar?token=123").
        to_return(:status => 401)

      assert_raises UCLAPI::Client::UnauthorizedError do
        @client.get('/foo/bar')
      end
    end

    it "should raise on 404" do
      stub_request(:get, "https://uclapi.com/foo/bar?token=123").
        to_return(:status => 404)

      assert_raises UCLAPI::Client::NotFoundError do
        @client.get('/foo/bar')
      end
    end
  end
end
