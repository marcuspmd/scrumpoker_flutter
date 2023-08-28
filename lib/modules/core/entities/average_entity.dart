import 'package:dson_adapter/dson_adapter.dart';

class AverageEntity {
  final double average;
  final double sd;

  AverageEntity({
    required this.average,
    required this.sd,
  });

  AverageEntity copyWith({
    double? average,
    double? sd,
  }) {
    return AverageEntity(
      average: average ?? this.average,
      sd: sd ?? this.sd,
    );
  }

  AverageEntity fromMap(Map<String, dynamic> map) {
    const dson = DSON();
    return dson.fromJson(map, AverageEntity.new);
  }
}
