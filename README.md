# ForecastProxy

Proxy server which provides GraphQL wrapper around [Dark Sky](https://darksky.net/dev) REST API.

## Libraries used

- [Phoenix](https://phoenixframework.org) as main framework.
- [Absinthe](https://hexdocs.pm/absinthe) for GraphQL API implementation.
- [Tesla](https://hexdocs.pm/tesla) to send REST requests.
- [GenServer](https://hexdocs.pm/elixir/GenServer.html) to implement caching.
- [ExUnit](https://hexdocs.pm/ex_unit) as testing framework.

## API

An example query and input can be found below.

> Amsterdam: 52.3667° N, 4.8945° E

Input:

```json
{
  "input": {
    "latitude": "52.3667",
    "longitude": "4.8945"
  }
}
```

Query:

```graphql
query WeatherForecast($input: CoordinateInput!) {
  weatherForecast(input: $input) {
    date
    type
    description
    temperature
    wind {
      speed
      bearing
    }
    precipitationProbability
    daily {
      date
      type
      description
      temperature {
        low
        high
      }
    }
  }
}
```

![Screenshot](assets/static/images/screenshot.png?raw=true)

## Live staging is available here:
https://portfolio-performance.herokuapp.com/graphiql
