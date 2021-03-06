final locationJson = '''
[
  {
    "title": "London",
    "location_type": "City",
    "woeid": 44418,
    "latt_long": "51.506321,-0.12714"
  }
]
''';

final weatherJson = '''
{
   "consolidated_weather":[
      {
         "id":5461767422476288,
         "weather_state_name":"Showers",
         "weather_state_abbr":"s",
         "wind_direction_compass":"SSW",
         "created":"2021-05-08T21:31:02.178215Z",
         "applicable_date":"2021-05-09",
         "min_temp":11.215,
         "max_temp":19.21,
         "the_temp":19.52,
         "wind_speed":9.539010474832311,
         "wind_direction":203.49996191774733,
         "air_pressure":997.5,
         "humidity":60,
         "visibility":13.764303964845304,
         "predictability":73
      },
      {
         "id":6587667329318912,
         "weather_state_name":"Light Rain",
         "weather_state_abbr":"lr",
         "wind_direction_compass":"SSW",
         "created":"2021-05-08T21:31:02.258667Z",
         "applicable_date":"2021-05-10",
         "min_temp":10.05,
         "max_temp":16.455,
         "the_temp":15.594999999999999,
         "wind_speed":11.529275508658765,
         "wind_direction":207.83465194935917,
         "air_pressure":1001.0,
         "humidity":58,
         "visibility":12.530260777061958,
         "predictability":75
      },
      {
         "id":4756281379258368,
         "weather_state_name":"Showers",
         "weather_state_abbr":"s",
         "wind_direction_compass":"S",
         "created":"2021-05-08T21:31:02.201759Z",
         "applicable_date":"2021-05-11",
         "min_temp":7.77,
         "max_temp":16.35,
         "the_temp":15.695,
         "wind_speed":7.510425012940427,
         "wind_direction":190.1527358841792,
         "air_pressure":1008.0,
         "humidity":52,
         "visibility":12.088155173785095,
         "predictability":73
      },
      {
         "id":4736373215985664,
         "weather_state_name":"Showers",
         "weather_state_abbr":"s",
         "wind_direction_compass":"SSW",
         "created":"2021-05-08T21:31:02.430665Z",
         "applicable_date":"2021-05-12",
         "min_temp":10.085,
         "max_temp":16.83,
         "the_temp":14.97,
         "wind_speed":7.609239891036347,
         "wind_direction":196.71867207862007,
         "air_pressure":1009.0,
         "humidity":52,
         "visibility":10.672360912272328,
         "predictability":73
      },
      {
         "id":5057042889834496,
         "weather_state_name":"Heavy Rain",
         "weather_state_abbr":"hr",
         "wind_direction_compass":"E",
         "created":"2021-05-08T21:31:04.679194Z",
         "applicable_date":"2021-05-13",
         "min_temp":9.28,
         "max_temp":14.125,
         "the_temp":9.69,
         "wind_speed":4.401046886184681,
         "wind_direction":93.50000000000001,
         "air_pressure":1005.0,
         "humidity":73,
         "visibility":9.999726596675416,
         "predictability":77
      },
      {
         "id":5090145276526592,
         "weather_state_name":"Heavy Rain",
         "weather_state_abbr":"hr",
         "wind_direction_compass":"NNE",
         "created":"2021-05-08T21:31:07.689479Z",
         "applicable_date":"2021-05-14",
         "min_temp":8.36,
         "max_temp":14.475,
         "the_temp":14.59,
         "wind_speed":4.9350771494472285,
         "wind_direction":32.5,
         "air_pressure":1007.0,
         "humidity":60,
         "visibility":9.775411596277738,
         "predictability":77
      }
   ],
   "time":"2021-05-09T00:50:04.591371+01:00",
   "sun_rise":"2021-05-09T05:17:56.648173+01:00",
   "sun_set":"2021-05-09T20:36:58.715052+01:00",
   "timezone_name":"LMT",
   "parent":{
      "title":"England",
      "location_type":"Region / State / Province",
      "woeid":24554868,
      "latt_long":"52.883560,-1.974060"
   },
   "sources":[
      {
         "title":"BBC",
         "slug":"bbc",
         "url":"http://www.bbc.co.uk/weather/",
         "crawl_rate":360
      },
      {
         "title":"Forecast.io",
         "slug":"forecast-io",
         "url":"http://forecast.io/",
         "crawl_rate":480
      },
      {
         "title":"HAMweather",
         "slug":"hamweather",
         "url":"http://www.hamweather.com/",
         "crawl_rate":360
      },
      {
         "title":"Met Office",
         "slug":"met-office",
         "url":"http://www.metoffice.gov.uk/",
         "crawl_rate":180
      },
      {
         "title":"OpenWeatherMap",
         "slug":"openweathermap",
         "url":"http://openweathermap.org/",
         "crawl_rate":360
      },
      {
         "title":"Weather Underground",
         "slug":"wunderground",
         "url":"https://www.wunderground.com/?apiref=fc30dc3cd224e19b",
         "crawl_rate":720
      },
      {
         "title":"World Weather Online",
         "slug":"world-weather-online",
         "url":"http://www.worldweatheronline.com/",
         "crawl_rate":360
      }
   ],
   "title":"London",
   "location_type":"City",
   "woeid":44418,
   "latt_long":"51.506321,-0.12714",
   "timezone":"Europe/London"
}
''';
