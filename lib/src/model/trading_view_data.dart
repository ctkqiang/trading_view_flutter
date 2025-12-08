import 'package:trading_view_flutter/src/model/constant.dart';
import 'package:trading_view_flutter/src/model/interval.dart';
import 'package:trading_view_flutter/src/model/theme.dart';

class TradingViewData {
  final int id;
  final String symbol;
  final bool autosize;
  final TradingViewInterval? interval;
  final String? timezone;
  final TradingViewTheme? theme;
  final String? style;
  final String? locale;
  final bool? hideTopToolbar;
  final bool? allowSymbolChange;
  final bool? saveImage;
  final bool? showCalendar;
  final bool? hideVolume;
  final String? supportHost;

  TradingViewData({
    required this.id,
    required this.symbol,
    this.autosize = true,
    this.interval = TradingViewInterval.D,
    this.timezone = 'Etc/UTC',
    this.theme = TradingViewTheme.light,
    this.style = '1',
    this.locale = 'zh',
    this.hideTopToolbar = false,
    this.allowSymbolChange = true,
    this.saveImage = false,
    this.showCalendar = false,
    this.hideVolume = false,
    this.supportHost = Constant.tradingViewUrl,
  }) : assert(symbol.isNotEmpty, 'symbol 不能为空');

  factory TradingViewData.fromJson(Map<String, dynamic> json) {
    return TradingViewData(
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
      showCalendar: json['show_calendar'],
      hideVolume: json['hide_volume'],
      supportHost: json['support_host'],
    );
  }

  Map<String, Object> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'autosize': autosize,
      'interval': interval?.name ?? TradingViewInterval.D.name,
      'timezone': timezone ?? 'Etc/UTC',
      'theme': theme?.name ?? TradingViewTheme.light.name,
      'style': style ?? '1',
      'locale': locale ?? 'zh',
      'hide_top_toolbar': hideTopToolbar ?? false,
      'allow_symbol_change': allowSymbolChange ?? true,
      'save_image': saveImage ?? false,
      'show_calendar': showCalendar ?? false,
      'hide_volume': hideVolume ?? false,
      'support_host': supportHost ?? Constant.tradingViewUrl,
    };
  }

  @override
  String toString() {
    return 'TradingViewData{id: $id, symbol: $symbol, autosize: $autosize, interval: $interval, timezone: $timezone, theme: $theme, style: $style, locale: $locale, hideTopToolbar: $hideTopToolbar, allowSymbolChange: $allowSymbolChange, saveImage: $saveImage, showCalendar: $showCalendar, hideVolume: $hideVolume, supportHost: $supportHost}';
  }
}
