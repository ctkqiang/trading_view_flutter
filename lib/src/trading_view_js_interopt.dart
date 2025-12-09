import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:trading_view_flutter/src/model/chart_region.dart';
import 'package:trading_view_flutter/trading_view_flutter.dart';

class TradingViewJsInteropt {
  static String getTradingViewWCode({
    required TradingViewData tradingViewData,
    String? footer = '',
  }) {
    final logger = Logger();

    if (kDebugMode) {
      logger.d('TradingViewWCode: ${tradingViewData.toString()}');
    }

    final jsonString = jsonEncode(tradingViewData.toJson());

    if (tradingViewData.isLightWeightChart!) {
      final chartDataJson = jsonEncode(
        tradingViewData.chartValue?.map((item) => item.toJson()).toList() ?? [],
      );

      if (kDebugMode) logger.d('chartValue: $chartDataJson');

      if (tradingViewData.tradingViewChartType ==
          TradingViewChartType.candlestick) {
        return '''
          <div
          class="tradingview-widget-container__widget" 
            style="
              border:  1px solid #888;  
              box-shadow: 0 2px 6px rgba(0,0,0,0.1);
              background: ${tradingViewData.theme == TradingViewTheme.light ? 'white' : 'black'};
            ">
            <div id="symbol" style="font-size:16px; font-weight:bold; margin-bottom:4px;">
              ${tradingViewData.symbol}
            </div>

            <div id="container" style="width:100%; height:250px;"></div>

            <script>
              (function() {
                var script = document.createElement('script');

                script.src = '${Constant.tradingLightChartWidgetUrl}';1
                script.onload = function() {
                  var checkReady = setInterval(function() {

                    if (window.LightweightCharts) {
                      clearInterval(checkReady);

                      const chartOptions = {
                        layout: {
                          textColor: '${(tradingViewData.theme == TradingViewTheme.light ? 'black' : 'white')}',
                          background: { type: 'solid', color: ' ${tradingViewData.theme == TradingViewTheme.light ? 'white' : 'black'}' }
                        }
                      };

                      const chart = LightweightCharts.createChart(
                        document.getElementById('container'),
                        chartOptions
                      );

                      const candlestickSeries = chart.addCandlestickSeries({
                        upColor: '${tradingViewData.chartRegion == ChartRegion.china ? '#ef5350' : '#26a69a'}',
                        downColor: '${tradingViewData.chartRegion == ChartRegion.china ? '#26a69a' : '#ef5350'}',
                        borderVisible: false,
                        wickUpColor: '${tradingViewData.chartRegion == ChartRegion.china ? '#ef5350' : '#26a69a'}',
                        wickDownColor: '${tradingViewData.chartRegion == ChartRegion.china ? '#26a69a' : '#ef5350'}'
                      });

                      candlestickSeries.setData($chartDataJson);

                      chart.timeScale().fitContent();
                    }
                  }, 50);
                };

                document.head.appendChild(script);
              })();
            </script>
          </div>
          ''';
      }

      return '''
          <p>unknown</p>
      ''';
    } else {
      return '''
      <div>
        <div class="tradingview-widget-container__widget" ></div>
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
