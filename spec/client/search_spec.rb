require_relative '../test_helper'

describe 'UCLAPI::Client::Search' do

  describe '.people' do
    before do
      @client = Minitest::Mock.new
      @query = { query: 'John' }
      @search = UCLAPI::Client::Search.new @client
      @people = { 'people' => [{ name: 'John Doe' }] }
    end

    it "should return if succesful" do
      @client.expect :get, @people, ["/search/people", @query]
      people = @search.people(@query)
      people.first.name.must_equal 'John Doe'
      @client.verify
    end

    it "should error if params are missing" do
      @query.delete(:query)
      assert_raises KeyError do
        @search.people(@query)
      end
    end
  end
end
