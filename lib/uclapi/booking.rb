class UCLAPI::Booking < OpenStruct
  def room
    client.roombookings.rooms(
      roomid: roomid,
      siteid: siteid
    ).first
  end

  def next_page(params = {})
    client.roombookings.bookings(params.merge({
      roomid: roomid,
      siteid: siteid,
      page_token: page_token
    }))
  end
end
