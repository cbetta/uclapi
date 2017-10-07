require_relative './test_helper'

describe 'UCLAPI::Booking' do

  describe '.room' do
    it "should delegate to the client" do
      @client = Minitest::Mock.new
      @booking = UCLAPI::Booking.new roomid: 123, siteid: 234, client: @client
      @roombookings = Minitest::Mock.new

      @client.expect :roombookings, @roombookings
      @roombookings.expect :rooms, [:room1, :room2], [{ roomid: 123, siteid: 234}]

      room = @booking.room
      room.must_equal :room1

      @client.verify
      @roombookings.verify
    end
  end

  describe '.next_page' do
    it "should delegate to the client" do
      @client = Minitest::Mock.new
      @booking = UCLAPI::Booking.new roomid: 123, siteid: 234, page_token: 456, client: @client
      @roombookings = Minitest::Mock.new

      @client.expect :roombookings, @roombookings
      @roombookings.expect :bookings, [:booking1, :booking2], [{ roomid: 123, siteid: 234, page_token: 456}]

      bookings = @booking.next_page
      bookings.first.must_equal :booking1

      @client.verify
      @roombookings.verify
    end
  end
end
