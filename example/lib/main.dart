import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trading_view_flutter/trading_view_flutter.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(TradingViewExample());
}

class TradingViewExample extends StatelessWidget {
  const TradingViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    final tradingData = TradingViewData(
      id: 0,
      symbol: 'SZSE:002594',
      autosize: true,
      interval: TradingViewInterval.month,
      timezone: 'Asia/Shanghai',
      theme: TradingViewTheme.light,
      style: '1',
      locale: TradingLocale.chinese.toLocaleString(),
      hideTopToolbar: true,
      allowSymbolChange: false,
      saveImage: false,
      showCalendar: true,
      hideVolume: false,
      isLightWeightChart: false,
      tradingViewChartType: TradingViewChartType.candlestick,
    );

    final tradingDataLight = TradingViewData(
      id: 0,
      symbol: 'SZSE:002594',
      autosize: true,
      interval: TradingViewInterval.month,
      timezone: 'Asia/Shanghai',
      theme: TradingViewTheme.light,
      style: '1',
      locale: 'zh',
      hideTopToolbar: true,
      allowSymbolChange: false,
      saveImage: false,
      showCalendar: true,
      hideVolume: false,
      isLightWeightChart: true,
      tradingViewChartType: TradingViewChartType.candlestick,
    );

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('TradingView 示例'),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Text(
              'Default TradingView | 默认TradingView',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 300,
              child: TradingViewWidget(
                data: tradingData,
                width: 600,
                height: 300,
              ),
            ),

            SizedBox(height: 30),

            Text(
              'LightWeight Chart TradingView | 轻量级图表TradingView',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 300,
              child: TradingViewWidget(
                data: tradingDataLight,
                width: 600,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
