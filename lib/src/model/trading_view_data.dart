import 'package:trading_view_flutter/src/model/chart_type.dart';
import 'package:trading_view_flutter/src/model/chart_region.dart';
import 'package:trading_view_flutter/src/model/constant.dart';
import 'package:trading_view_flutter/src/model/interval.dart';
import 'package:trading_view_flutter/src/model/theme.dart';
import 'package:trading_view_flutter/src/model/trading_view_chart_data.dart';

/// [TradingViewData]
///  TradingView 数据模型
///
///  K线数据模型
///   本模型遵循金融市场数据标准，用于表示标准化K线数据。
///
/// [symbol] The symbol of the stocke ticker
/// [autosize] if tureue the trading view will auto resize the view to fit the parent container
///  [interval] The interval of the chart refer [TradingViewInterval]
///
///  [timezone] The timezone of the chart （IANA 时区标识符） format default "Asia/Shanghai"
/// [theme] The theme of the chart refer [TradingViewTheme]1
///
class TradingViewData {
  final int? id;
  final String symbol;
  final bool autosize;
  final String? interval;
  final String? timezone;
  final TradingViewTheme? theme;
  final String? style;
  final String? locale;
  final bool? hideTopToolbar;
  final bool? allowSymbolChange;
  final bool? saveImage;
  final bool? showCalendar;
  final bool? hideVolume;
  final bool? showDrawingToolBar;
  final bool? showComprehennsiveDetails;
  final String? supportHost;
  final bool? isLightWeightChart;
  final ChartRegion? chartRegion;
  final TradingViewChartType? tradingViewChartType;
  final List<TradingViewChartData>? chartValue;

  // TODO add indicator

  TradingViewData({
    this.id,
    required this.symbol,
    this.autosize = true,
    this.interval = TradingViewInterval.day,
    this.timezone = 'Asia/Shanghai',
    this.theme = TradingViewTheme.light,
    this.style = '1',
    this.locale = 'zh',
    this.hideTopToolbar = false,
    this.allowSymbolChange = true,
    this.saveImage = false,
    this.showCalendar = false,
    this.hideVolume = false,
    this.showDrawingToolBar = false,
    this.showComprehennsiveDetails = false,
    this.supportHost = Constant.tradingViewUrl,
    this.isLightWeightChart = false,
    this.chartRegion = ChartRegion.china,
    this.tradingViewChartType = TradingViewChartType.candlestick,
    this.chartValue,
  }) : assert(symbol.isNotEmpty, 'symbol 不能为空');

  factory TradingViewData.fromJson(Map<String, dynamic> json) {
    if (json['isLightWeightChart'] == true && json['chartValue'] == null) {
      assert(
        json['chartValue'].isNotEmpty,
        'chartValue 不可为空，因为您将轻量级图表设置为 true',
      );
    }

    TradingViewData data = TradingViewData(
      id: json['id'],
      symbol: json['symbol'],
      autosize: json['autosize'],
      interval: json['interval'],
      timezone: json['timezone'],
      theme: json['theme'],
      style: json['style'],
      locale: json['locale'],
      hideTopToolbar: json['hide_top_toolbar'],
      allowSymbolChange: json['allow_symbol_change'],
      saveImage: json['save_image'],
      showComprehennsiveDetails: json['show_comprehensive_details'],
      showCalendar: json['show_calendar'],
      hideVolume: json['hide_volume'],
      supportHost: json['support_host'],
      isLightWeightChart: json['isLightWeightChart'],
      chartValue: (json['chartValue']),
      chartRegion: json['chartRegion'],
      showDrawingToolBar: json['showDrawingToolBar'],
    );

    return data;
  }

  Map<String, Object> toJson() {
    Map<String, Object> data = {
      'id': id ?? 0,
      'symbol': symbol,
      'autosize': autosize,
      'interval': interval ?? TradingViewInterval.day,
      'timezone': timezone ?? 'Etc/UTC',
      'theme': theme?.name ?? TradingViewTheme.light.name,
      'style': style ?? '1',
      'locale': locale ?? 'zh',
      'hide_top_toolbar': hideTopToolbar ?? false,
      'allow_symbol_change': allowSymbolChange ?? true,
      'save_image': saveImage ?? false,
      'details': showComprehennsiveDetails ?? false,
      'show_calendar': showCalendar ?? false,
      'hide_volume': hideVolume ?? false,
      'support_host': supportHost ?? Constant.tradingViewUrl,
      'hide_side_toolbar': !showDrawingToolBar!,
    };

    return data;
  }

  @override
  String toString() {
    return 'TradingViewData{id: $id, symbol: $symbol, autosize: $autosize, interval: $interval, timezone: $timezone, theme: $theme, style: $style, locale: $locale, hideTopToolbar: $hideTopToolbar, allowSymbolChange: $allowSymbolChange, saveImage: $saveImage, showCalendar: $showCalendar, hideVolume: $hideVolume, supportHost: $supportHost}';
  }
}
