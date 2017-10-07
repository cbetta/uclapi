class UCLAPI::Client::Search
  def initialize client
    @client = client
  end

  def people(params = {})
    @client.get('/search/people', params)['people'].map do |people|
      people[:client] = @client
      UCLAPI::People.new(people)
    end
  end
end
