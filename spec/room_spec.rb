require_relative './test_helper'

describe 'UCLAPI::Room' do

  describe '.bookings' do
    it "should delegate to the client" do
      @client = Minitest::Mock.new
      @room = UCLAPI::Room.new roomid: 123, siteid: 234, client: @client
      @roombookings = Minitest::Mock.new

      @client.expect :roombookings, @roombookings
      @roombookings.expect :bookings, [:booking1, :booking2], [{ roomid: 123, siteid: 234}]

      bookings = @room.bookings
      bookings.must_equal [:booking1, :booking2]

      @client.verify
      @roombookings.verify
    end
  end

  describe '.equipment' do
    it "should delegate to the client" do
      @client = Minitest::Mock.new
      @room = UCLAPI::Room.new roomid: 123, siteid: 234, client: @client
      @roombookings = Minitest::Mock.new

      @client.expect :roombookings, @roombookings
      @roombookings.expect :equipment, [OpenStruct.new, OpenStruct.new], [{ roomid: 123, siteid: 234}]

      equipment = @room.equipment
      equipment.first.roomid.must_equal 123
      equipment.first.siteid.must_equal 234

      @client.verify
      @roombookings.verify
    end
  end
end
