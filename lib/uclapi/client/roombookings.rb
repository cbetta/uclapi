class UCLAPI::Client::Roombookings
  def initialize client
    @client = client
  end

  def rooms(params = {})
    @client.get('/roombookings/rooms', params)['rooms'].map do |room|
      room[:client] = @client
      UCLAPI::Room.new(room)
    end
  end

  def bookings(params = {})
    result = @client.get('/roombookings/bookings', params)
    result['bookings'].map do |booking|
      booking[:client] = @client
      booking[:page_token] = result['page_token']
      UCLAPI::Booking.new(booking)
    end
  end

  def equipment(params = {})
    @client.get('/roombookings/equipment', params)['equipment'].map do |equipment|
      equipment[:client] = @client
      UCLAPI::Equipment.new(equipment)
    end
  end
end
