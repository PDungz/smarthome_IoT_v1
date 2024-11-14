import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Websocket {
  final double gasValue;
  final double humidity;
  final double temperature;
  final String accessKey;

  Websocket({
    required this.gasValue,
    required this.humidity,
    required this.temperature,
    required this.accessKey,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gasValue': gasValue,
      'humidity': humidity,
      'temperature': temperature,
      'accessKey': accessKey,
    };
  }

  factory Websocket.fromMap(Map<String, dynamic> map) {
    return Websocket(
      gasValue: map['gas_value'] as double,
      humidity: map['humidity'] as double,
      temperature: map['temperature'] as double,
      accessKey: map['accessKey'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Websocket.fromJson(String source) =>
      Websocket.fromMap(json.decode(source) as Map<String, dynamic>);
}
