/// K线数据模型
///
/// 本模型遵循金融市场数据标准，用于表示标准化K线数据。
/// 符合《金融数据安全分级指南》及相关监管要求，仅包含公开市场数据。
/// [TradingViewChartData]
/// 数据字段说明：
///   - 开盘价 [open]: 交易时段开始时的首次成交价
///   - 最高价 [high]: 交易时段内的最高成交价
///   - 最低价 [low]: 交易时段内的最低成交价
///   - 收盘价 [close]: 交易时段结束时的最后成交价
///   - 时间戳 [time]: 数据对应时间，格式为'yyyy-MM-dd'（符合GB/T 7408-2005标准）
class TradingViewChartData {
  final double open;
  final double high;
  final double low;
  final double close;
  final String time;

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
