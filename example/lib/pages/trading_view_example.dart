import 'package:flutter/material.dart';
import 'package:trading_view_flutter/trading_view_flutter.dart';

class TradingViewExample extends StatefulWidget {
  const TradingViewExample({super.key});

  @override
  State<TradingViewExample> createState() => _TradingViewExampleState();
}

class _TradingViewExampleState extends State<TradingViewExample> {
  TradingViewTheme? _theme = TradingViewTheme.light;

  @override
  Widget build(BuildContext context) {
    final fakeChartData = <TradingViewChartData>[
      TradingViewChartData(
        time: DateTime(2025, 12, 22),
        open: 75.16,
        high: 82.84,
        low: 36.16,
        close: 45.72,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 23),
        open: 45.12,
        high: 53.90,
        low: 45.12,
        close: 48.09,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 24),
        open: 60.71,
        high: 60.71,
        low: 53.39,
        close: 59.29,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 25),
        open: 68.26,
        high: 68.26,
        low: 59.04,
        close: 60.50,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 26),
        open: 67.71,
        high: 105.85,
        low: 66.67,
        close: 91.04,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 27),
        open: 91.04,
        high: 121.40,
        low: 82.70,
        close: 111.40,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 28),
        open: 111.51,
        high: 142.83,
        low: 103.34,
        close: 131.25,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 29),
        open: 131.33,
        high: 151.17,
        low: 77.68,
        close: 96.43,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 30),
        open: 106.33,
        high: 110.20,
        low: 90.39,
        close: 98.10,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 31),
        open: 50.87,
        high: 114.69,
        low: 30.66,
        close: 111.26,
      ),
    ];

    final tradingData = TradingViewData(
      id: 0,
      symbol: 'SZSE:002594',
      autosize: true,
      interval: TradingViewInterval.month,
      timezone: 'Asia/Shanghai',
      theme: _theme,
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
      theme: _theme, // 使用状态变量
      style: '1',
      locale: 'zh',
      hideTopToolbar: true,
      allowSymbolChange: false,
      saveImage: false,
      showCalendar: true,
      hideVolume: false,
      isLightWeightChart: true,
      tradingViewChartType: TradingViewChartType.candlestick,
      chartValue: fakeChartData,
    );

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('TradingView 示例'),
          backgroundColor: Colors.white,
          actions: [
            Switch(
              value: _theme == TradingViewTheme.dark, // 使用状态变量
              onChanged: (value) {
                setState(() {
                  _theme = value
                      ? TradingViewTheme.dark
                      : TradingViewTheme.light; // 更新状态变量
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Text(
              'Default TradingView | 默认TradingView',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 300,
                child: TradingViewWidget(
                  data: tradingData,
                  width: 600,
                  height: 300,
                ),
              ),
            ),

            SizedBox(height: 30),

            Text(
              'LightWeight Chart TradingView | 轻量级图表TradingView',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 300,
                child: TradingViewWidget(
                  data: tradingDataLight,
                  width: 600,
                  height: 300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
