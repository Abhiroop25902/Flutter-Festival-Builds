class WeatherInfo {
  final String localTime;
  final int tempC;
  final String iconUrl;
  final String name;
  final String region;

  const WeatherInfo(
      {required this.localTime,
      required this.tempC,
      required this.iconUrl,
      required this.name,
      required this.region});

  factory WeatherInfo.getDummy() {
    return const WeatherInfo(
        localTime: "2022-03-28 19:07",
        tempC: 30,
        iconUrl: 'http://cdn.weatherapi.com/weather/64x64/night/122.png',
        name: "Mumbai",
        region: "Maharashtra");
  }

  factory WeatherInfo.fromJson({required Map<String, dynamic> json}) {
    return WeatherInfo(
        localTime: json['location']['localtime'],
        tempC: (json['current']['temp_c'] as double).round(),
        iconUrl: "http:" + json['current']['condition']['icon'],
        name: json['location']['name'],
        region: json['location']['region']);
  }
}
