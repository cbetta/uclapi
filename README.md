# Ruby API library for the UCL API

[![Gem Version](https://badge.fury.io/rb/uclapi.svg)](https://badge.fury.io/rb/uclapi) [![Build Status](https://travis-ci.org/cbetta/uclapi.svg?branch=master)](https://travis-ci.org/cbetta/uclapi)

A wrapper for the [UCL API](https://uclapi.com/). Specification is as described in the the [developer documentation](https://docs.uclapi.com/).

## Installation

Either install directly or via bundler.

```rb
gem 'uclapi'
```

## Getting started

The client will accept the app token either as a parameter on initialization,
or as an environment variable. Additionally a `debug` parameter can be set to enable verbose debugging.

```rb
require 'uclapi'

# using parameters
client = UCLAPI::Client.new(token: '...')

# using environment variables:
# * UCLAPI_TOKEN
client = UCLAPI::Client.new
```

The client provides with direct access to every API call as documented in the
developer documentation. Additionally it also provides some convenience methods.

```rb
# get a room
room = client.roombookings.rooms.first
# get the bookings for a room
bookings = room.bookings
# get the equipment for a room
equipment = room.equipment
```

## Convenience methods

### `room.bookings`

Maps to `client.roombookings.bookings` and passes along all the
same parameters while automatically setting the `roomid` and `siteid`.

### `room.equipment`

Maps to `client.roombookings.equipment` and passes along all the
same parameters while automatically setting the `roomid` and `siteid`.

### `booking.room`

Maps to `client.roombookings.room` and passes along the `roomid` and `siteid`.

### `booking.next_page`

Maps to `client.roombookings.bookings` and passes along the `roomid`, `siteid` and `page_token` to fetch the next page.

### `equipment.room`

Maps to `client.roombookings.room` and passes along the `roomid` and `siteid`.


## API

### `GET /roombookings/rooms`

This endpoint returns rooms and information about them. If you don’t specify any query parameters besides the token, all rooms will be returned.

More: [Documentation](https://docs.uclapi.com/#get-rooms)

```rb
> rooms = client.roombookings.rooms
[#<UCLAPI::Room siteid="123" ....>, #<UCLAPI::Room siteid="123" ....>]
> rooms.first
UCLAPI::Room {
            :siteid => "123",
          :location => {
        "coordinates" => {
            "lat" => "51.523504",
            "lng" => "-0.134937"
        },
            "address" => [
            [0] "74 Huntley Street",
            [1] "London",
            [2] "WC1E 6AU",
            [3] ""
        ]

    },
            :roomid => "234",
          :sitename => "Medical School Building",
          :roomname => "Rockefeller Building 335",
         :automated => "P",
          :capacity => 20,
    :classification => "CR"
}
# optional provide any extra parameters
> rooms = client.roombookings.rooms(siteid: 123)
```

### `GET /roombookings/bookings`

This endpoint shows the results to a bookings or space availability query. It returns a paginated list of bookings.

More: [Documentation](https://docs.uclapi.com/#get-bookings)

```rb
> bookings = client.roombookings.bookings
[#<UCLAPI::Booking slotid="1234567" ....>, ...]
> bookings.first
UCLAPI::Booking {
         :siteid => "123",
       :end_time => "2018-02-01T12:00:00+00:00",
         :roomid => "456",
         :slotid => 1234567,
          :phone => nil,
       :roomname => "IOE - Bedford Way (20) - 790",
     :start_time => "2018-02-01T11:00:00+00:00",
        :contact => "Mr John Doe",
    :description => "Introduction to The UCL API",
     :weeknumber => 23.0
}
# optional provide any extra parameters
> bookings = client.roombookings.bookings(siteid: 374)
# to fetch the next page, just call next_page on any book
> next_bookings = bookings.first.next_page
```

### `GET /roombookings/equipment`

This endpoint returns any equipment/feature information about a specific room. So, for example whether there is a Whiteboard or a DVD Player in the room.

More: [Documentation](https://docs.uclapi.com/#get-equipment)

```rb
> equipment = client.roombookings.equipment(siteid: 123, roomid: 345)
[#<UCLAPI::Equipment description="White Board" ....>, ...]
> equipment.first
UCLAPI::Equipment {
    :description => "White Board",
           :type => "FF",
          :units => 1,
         :roomid => "335",
         :siteid => "374"
}
```

### `GET /search/people`

This endpoint returns matching people and information about them.
More: [Documentation](https://docs.uclapi.com/#get-people)

```rb
> people = client.search.people(query: 'John')
[#<UCLAPI::People name="John Doe" ....>, ...]
> people.first
UCLAPI::People {
        :status => "Staff",
          :name => "John Doe",
         :email => "j.doe@ucl.ac.uk",
    :department => "UCL API Development"
}
```

## Contributing

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull request** so that we can review your changes

### Development

* `bundle install` to get dependencies
* `rake` to run tests
* `rake console` to run a local console with the library loaded

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in this project is expected to follow the [code of conduct](https://github.com/cbetta/uclapi/blob/master/CODE_OF_CONDUCT.md).
