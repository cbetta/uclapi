class UCLAPI::Booking < OpenStruct
  def room
    client.roombookings.rooms(
      roomid: roomid,
      siteid: siteid
    ).first
  end
end
