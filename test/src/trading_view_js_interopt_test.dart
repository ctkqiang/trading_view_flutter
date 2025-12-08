import 'package:flutter_test/flutter_test.dart';
import 'package:trading_view_flutter/src/trading_view_js_interopt.dart';

void main() {
  group('TradingViewJsInteropt', () {
    const defaultJson = {
      'symbol': 'SZSE:002594',
      'interval': 'M',
      'timezone': 'Asia/Shanghai',
      'theme': 'light',
      'style': '1',
      'locale': 'zh',
    };

    test('should generate correct TradingView widget code with default parameters', () {
      // When
      final result = TradingViewJsInteropt.getTradingViewWCode(json: defaultJson);

      // Then
      expect(result, contains('tradingview-widget-container'));
      expect(result, contains('SZSE:002594'));
      expect(result, contains('embed-widget-advanced-chart.js'));
      expect(result, contains('text/javascript'));
    });

    test('should include JSON data in script tag', () {
      // When
      final result = TradingViewJsInteropt.getTradingViewWCode(json: defaultJson);

      // Then
      expect(result, contains('\"symbol\":\"SZSE:002594\"'));
      expect(result, contains('\"interval\":\"M\"'));
      expect(result, contains('\"theme\":\"light\"'));
    });

    test('should use lightweight charts when isLightWeightChart is true', () {
      // When
      final result = TradingViewJsInteropt.getTradingViewWCode(
        json: defaultJson,
        isLightWeightChart: true,
      );

      // Then
      expect(result, contains('lightweight-charts.standalone.production.js'));
      expect(result, isNot(contains('embed-widget-advanced-chart.js')));
    });

    test('should use advanced charts when isLightWeightChart is false', () {
      // When
      final result = TradingViewJsInteropt.getTradingViewWCode(
        json: defaultJson,
        isLightWeightChart: false,
      );

      // Then
      expect(result, contains('embed-widget-advanced-chart.js'));
      expect(result, isNot(contains('lightweight-charts')));
    });

    test('should include custom footer text', () {
      // Given
      const customFooter = 'Custom Trading View';

      // When
      final result = TradingViewJsInteropt.getTradingViewWCode(
        json: defaultJson,
        footer: customFooter,
      );

      // Then
      expect(result, contains(customFooter));
      expect(result, contains('blue-text'));
    });

    test('should handle empty JSON object', () {
      // When
      final result = TradingViewJsInteropt.getTradingViewWCode(json: {});

      // Then
      expect(result, isNotEmpty);
      expect(result, contains('tradingview-widget-container'));
      expect(result, contains('{}')); // Empty JSON in script tag
    });

    test('should handle complex JSON structures', () {
      // Given
      final complexJson = {
        'symbol': 'SZSE:002594',
        'studies': ['RSI@tv-basicstudies', 'MACD@tv-basicstudies'],
        'drawings': ['LineTool@tv-basicdrawings'],
        'indicators': ['Accumulation/Distribution@tv-basicindicators'],
        'timezone': 'Asia/Shanghai',
        'theme': 'dark',
        'style': '3',
        'locale': 'en',
        'toolbar_bg': '#f1f3f6',
        'enable_publishing': false,
        'hide_top_toolbar': true,
        'hide_legend': false,
        'save_image': true,
        'container_id': 'tradingview_widget',
      };

      // When
      final result = TradingViewJsInteropt.getTradingViewWCode(json: complexJson);

      // Then
      expect(result, contains('\"studies\":['));
      expect(result, contains('\"drawings\":['));
      expect(result, contains('\"hide_top_toolbar\":true'));
      expect(result, contains('\"enable_publishing\":false'));
    });

    test('should properly escape JSON special characters', () {
      // Given
      final jsonWithSpecialChars = {
        'symbol': 'SZSE:002594',
        'description': 'TradingView with "quotes" and \'apostrophes\'',
        'comment': 'Line\nBreak\tTab',
      };

      // When
      final result = TradingViewJsInteropt.getTradingViewWCode(json: jsonWithSpecialChars);

      // Then
      expect(result, contains('\"description\":\"TradingView with \\\"quotes\\\" and \\\'apostrophes\\\'\"'));
      expect(result, contains('\"comment\":\"Line\\\\nBreak\\\\tTab\"'));
    });

    test('should generate valid HTML structure', () {
      // When
      final result = TradingViewJsInteropt.getTradingViewWCode(json: defaultJson);

      // Then
      expect(result, startsWith('      <div class="tradingview-widget-container"'));
      expect(result, contains('</div>'));
      expect(result, contains('</script>'));
      expect(result, contains('style="height:100%;width:100%"'));
    });

    test('should handle null footer parameter', () {
      // When
      final result = TradingViewJsInteropt.getTradingViewWCode(
        json: defaultJson,
        footer: null,
      );

      // Then
      expect(result, contains('<span class="blue-text"></span>'));
    });

    test('should handle empty footer parameter', () {
      // When
      final result = TradingViewJsInteropt.getTradingViewWCode(
        json: defaultJson,
        footer: '',
      );

      // Then
      expect(result, contains('<span class="blue-text"></span>'));
    });

    test('should include correct container styling', () {
      // When
      final result = TradingViewJsInteropt.getTradingViewWCode(json: defaultJson);

      // Then
      expect(result, contains('style="height:100%;width:100%"'));
      expect(result, contains('style="height:calc(100% - 32px);width:100%"'));
    });

    test('should include TradingView copyright link', () {
      // When
      final result = TradingViewJsInteropt.getTradingViewWCode(json: defaultJson);

      // Then
      expect(result, contains('href="https://www.tradingview.com/"'));
      expect(result, contains('rel="noopener nofollow"'));
      expect(result, contains('target="_blank"'));
    });

    test('should handle different script loading strategies', () {
      // When
      final result = TradingViewJsInteropt.getTradingViewWCode(json: defaultJson);

      // Then
      expect(result, contains('async'));
      expect(result, contains('type="text/javascript"'));
    });
  });
}