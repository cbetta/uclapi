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
    @client.get('/roombookings/bookings', params)['bookings'].map do |booking|
      booking[:client] = @client
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
