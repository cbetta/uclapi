class UCLAPI::Equipment < OpenStruct
  def room
    client.roombookings.rooms(
      roomid: roomid,
      siteid: siteid
    ).first
  end
end
