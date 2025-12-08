import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:trading_view_flutter/src/model/chart_type.dart';
import 'package:trading_view_flutter/trading_view_flutter.dart';

class TradingViewJsInteropt {
  static String getTradingViewWCode({
    required TradingViewData tradingViewData,
    String? footer = '',
  }) {
    final logger = Logger();

    if (kDebugMode) {
      logger.d('TradingViewWCode: $json');
    }

    final jsonString = jsonEncode(json);

    if (tradingViewData.isLightWeightChart!) {
      if (tradingViewData.tradingViewChartType ==
          TradingViewChartType.candlestick) {
        return '''
        <div>
          <script type="text/javascript" src="${Constant.tradingLightChartWidgetUrl}" async>
            const chart = LightweightCharts.createChart(document.body);
            const lineSeries = chart.addSeries(LightweightCharts.LineSeries);

            lineSeries.setData(${tradingViewData.chartValue};
          </script>
        </div>
        ''';
      }

      return '''

      ''';
    } else {
      return '''
      <div class="tradingview-widget-container" style="height:100%;width:100%">
        <div class="tradingview-widget-container__widget" style="height:calc(100% - 32px);width:100%"></div>
        <div class="tradingview-widget-copyright">
          <a href="https://www.tradingview.com/" rel="noopener nofollow" target="_blank">
            <span class="blue-text">$footer</span>
          </a>
        </div>
        <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-advanced-chart.js" async>
          $jsonString
        </script>
      </div>
    ''';
    }
  }
}
