require_relative '../test_helper'

describe 'UCLAPI::Client::Roombookings' do

  describe '.rooms' do
    before do
      @client = Minitest::Mock.new
      @query = { roomid: 123 }
      @roombookings = UCLAPI::Client::Roombookings.new @client
      @rooms = { 'rooms' => [{ roomid: 123 }] }
    end

    it "should return if succesful" do
      @client.expect :get, @rooms, ["/roombookings/rooms", @query]
      rooms = @roombookings.rooms(@query)
      rooms.first.roomid.must_equal 123
      @client.verify
    end
  end

  describe '.bookings' do
    before do
      @client = Minitest::Mock.new
      @query = { roomid: 123 }
      @roombookings = UCLAPI::Client::Roombookings.new @client
      @bookings = { 'bookings' => [{ slotid: 123 }], 'page_token' => 234 }
    end

    it "should return if succesful" do
      @client.expect :get, @bookings, ["/roombookings/bookings", @query]
      bookings = @roombookings.bookings(@query)
      bookings.first.slotid.must_equal 123
      bookings.first.page_token.must_equal 234
      @client.verify
    end
  end

  describe '.equipment' do
    before do
      @client = Minitest::Mock.new
      @query = { roomid: 123 }
      @roombookings = UCLAPI::Client::Roombookings.new @client
      @equipment = { 'equipment' => [{ name: "Projector" }] }
    end

    it "should return if succesful" do
      @client.expect :get, @equipment, ["/roombookings/equipment", @query]
      equipment = @roombookings.equipment(@query)
      equipment.first.name.must_equal "Projector"
      @client.verify
    end
  end
end
