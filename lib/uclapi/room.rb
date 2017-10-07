class UCLAPI::Room < OpenStruct
  def bookings
    client.roombookings.bookings(
      roomid: roomid,
      siteid: siteid
    )
  end

  def equipment
    client.roombookings.equipment(
      roomid: roomid,
      siteid: siteid
    ).map do |equipment|
      equipment.roomid = roomid
      equipment.siteid = siteid
      equipment
    end
  end
end
