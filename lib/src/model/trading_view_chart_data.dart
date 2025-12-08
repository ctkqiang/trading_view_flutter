class TradingViewChartData {
  final double open;
  final double high;
  final double low;
  final double close;
  final int time;

  TradingViewChartData({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.time,
  });

  factory TradingViewChartData.fromJson(Map<String, dynamic> json) {
    return TradingViewChartData(
      open: json['open'],
      high: json['high'],
      low: json['low'],
      close: json['close'],
      time: json['time'],
    );
  }

  Map<String, Object> toJson() {
    return {
      'open': open,
      'high': high,
      'low': low,
      'close': close,
      'time': time,
    };
  }

  @override
  String toString() {
    return 'TradingViewChartData{open: $open, high: $high, low: $low, close: $close, time: $time}';
  }
}
