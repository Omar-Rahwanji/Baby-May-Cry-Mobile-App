import 'package:charts_flutter/flutter.dart' as charts;

class BarChartModel {
  String cryReason;
  int numberOfSounds;

  final charts.Color color;

  BarChartModel({
    required this.cryReason,
    required this.numberOfSounds,
    required this.color,
  });
}
