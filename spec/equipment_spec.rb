require_relative './test_helper'

describe 'UCLAPI::Equipment' do

  describe '.room' do
    it "should delegate to the client" do
      @client = Minitest::Mock.new
      @equipment = UCLAPI::Equipment.new roomid: 123, siteid: 234, client: @client
      @roombookings = Minitest::Mock.new

      @client.expect :roombookings, @roombookings
      @roombookings.expect :rooms, [:room1, :room2], [{ roomid: 123, siteid: 234}]

      room = @equipment.room
      room.must_equal :room1

      @client.verify
      @roombookings.verify
    end
  end
end
