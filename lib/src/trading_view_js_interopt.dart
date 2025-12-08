import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class TradingViewJsInteropt {
  static String getTradingViewWCode({
    required Map<String, Object> json,
    bool? isLightWeightChart = false,
    String? footer = '',
  }) {
    final logger = Logger();

    if (kDebugMode) {
      logger.d('TradingViewWCode: $json');
    }

    final jsonString = jsonEncode(json);

    if (isLightWeightChart!) {
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
