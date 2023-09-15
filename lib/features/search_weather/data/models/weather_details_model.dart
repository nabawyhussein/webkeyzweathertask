// To parse this JSON data, do
//
//     final weatherDetailsModel = weatherDetailsModelFromJson(jsonString);

class WeatherDetailsModel {
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final Current current;
  final List<Daily> daily;

  WeatherDetailsModel({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.daily,
  });

  WeatherDetailsModel copyWith({
    double? lat,
    double? lon,
    String? timezone,
    int? timezoneOffset,
    Current? current,
    List<Current>? hourly,
    List<Daily>? daily,
  }) =>
      WeatherDetailsModel(
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        timezone: timezone ?? this.timezone,
        timezoneOffset: timezoneOffset ?? this.timezoneOffset,
        current: current ?? this.current,
        daily: daily ?? this.daily,
      );

  factory WeatherDetailsModel.fromJson(Map<String, dynamic> json) =>
      WeatherDetailsModel(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        current: Current.fromJson(json["current"]),
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
        "timezone_offset": timezoneOffset,
        "current": current.toJson(),
        "daily": List<dynamic>.from(daily.map((x) => x.toJson())),
      };
}

class Current {
  final int dt;
  final double temp;
  final int humidity;
  final double windSpeed;
  final List<Weather> weather;

  Current({
    required this.dt,
    required this.temp,
    required this.humidity,
    required this.windSpeed,
    required this.weather,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json["dt"],
        temp: json["temp"]?.toDouble(),
        humidity: json["humidity"],
        windSpeed: json["wind_speed"]?.toDouble(),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "temp": temp,
        "humidity": humidity,
        "wind_speed": windSpeed,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
      };
}

class Weather {
  final int id;
  final String description;

  Weather({
    required this.id,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };
}

class Daily {
  final Temp temp;
  final List<Weather> weather;

  Daily({
    required this.temp,
    required this.weather,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        temp: Temp.fromJson(json["temp"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
      };
}

class Temp {
  final double day;
  final double min;
  final double max;

  Temp({
    required this.day,
    required this.min,
    required this.max,
  });

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"]?.toDouble(),
        min: json["min"]?.toDouble(),
        max: json["max"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "min": min,
        "max": max,
      };
}
