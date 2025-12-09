import 'package:example/pages/trading_view_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trading_view_flutter/trading_view_flutter.dart';

void main() {
  group('TradingViewExample 部件测试', () {
    // 基础渲染测试
    testWidgets('正常渲染不崩溃', (WidgetTester tester) async {
      await tester.pumpWidget(const TradingViewExample());
      await tester.pumpAndSettle();

      expect(find.byType(TradingViewExample), findsOneWidget);
    });

    // 部件结构验证
    testWidgets('具有正确的部件层级结构', (WidgetTester tester) async {
      await tester.pumpWidget(const TradingViewExample());
      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(TradingViewWidget), findsOneWidget);
    });

    // AppBar 内容验证
    testWidgets('显示正确的 AppBar 标题', (WidgetTester tester) async {
      await tester.pumpWidget(const TradingViewExample());
      await tester.pumpAndSettle();

      expect(find.text('TradingView Example'), findsOneWidget);
    });

    // TradingViewData 配置测试
    testWidgets('使用正确的参数创建 TradingViewData', (WidgetTester tester) async {
      await tester.pumpWidget(const TradingViewExample());
      await tester.pumpAndSettle();

      // 获取 TradingViewWidget
      final tradingViewFinder = find.byType(TradingViewWidget);
      final tradingViewWidget = tester.widget<TradingViewWidget>(
        tradingViewFinder,
      );

      // 验证 TradingViewData 参数
      expect(tradingViewWidget.data.id, 0);
      expect(tradingViewWidget.data.symbol, 'SZSE:002594');
      expect(tradingViewWidget.data.autosize, true);
      expect(tradingViewWidget.data.interval, TradingViewInterval.month);
      expect(tradingViewWidget.data.timezone, 'Asia/Shanghai');
      expect(tradingViewWidget.data.theme, TradingViewTheme.light);
      expect(tradingViewWidget.data.style, '1');
      expect(tradingViewWidget.data.locale, 'zh');
      expect(tradingViewWidget.data.hideTopToolbar, true);
      expect(tradingViewWidget.data.allowSymbolChange, false);
      expect(tradingViewWidget.data.saveImage, false);
      expect(tradingViewWidget.data.showCalendar, true);
      expect(tradingViewWidget.data.hideVolume, false);
    });

    // 主题测试
    testWidgets('使用浅色主题', (WidgetTester tester) async {
      await tester.pumpWidget(const TradingViewExample());
      await tester.pumpAndSettle();

      final tradingViewFinder = find.byType(TradingViewWidget);
      final tradingViewWidget = tester.widget<TradingViewWidget>(
        tradingViewFinder,
      );

      expect(tradingViewWidget.data.theme, TradingViewTheme.light);
    });

    // 本地化测试
    testWidgets('使用中文本地化', (WidgetTester tester) async {
      await tester.pumpWidget(const TradingViewExample());
      await tester.pumpAndSettle();

      final tradingViewFinder = find.byType(TradingViewWidget);
      final tradingViewWidget = tester.widget<TradingViewWidget>(
        tradingViewFinder,
      );

      expect(tradingViewWidget.data.locale, 'zh');
    });

    // 交互测试 - 部件可点击
    testWidgets('TradingViewWidget 可以接收点击', (WidgetTester tester) async {
      await tester.pumpWidget(const TradingViewExample());
      await tester.pumpAndSettle();

      final tradingViewFinder = find.byType(TradingViewWidget);

      // 尝试点击 TradingViewWidget
      await tester.tap(tradingViewFinder);
      await tester.pump();

      // 验证部件仍然存在
      expect(tradingViewFinder, findsOneWidget);
    });

    // MaterialApp 配置测试
    testWidgets('MaterialApp 具有正确的配置', (WidgetTester tester) async {
      await tester.pumpWidget(const TradingViewExample());
      await tester.pumpAndSettle();

      final materialAppFinder = find.byType(MaterialApp);
      final materialApp = tester.widget<MaterialApp>(materialAppFinder);

      // 验证 MaterialApp 属性
      expect(materialApp.home, isNotNull);
      expect(materialApp.home, isA<Scaffold>());
    });
  });

  group('TradingViewExample 边界情况测试', () {
    // 重建测试
    testWidgets('部件重建后保持一致性', (WidgetTester tester) async {
      await tester.pumpWidget(const TradingViewExample());
      await tester.pumpAndSettle();

      final initialWidget = tester.widget<TradingViewWidget>(
        find.byType(TradingViewWidget),
      );

      // 重建部件
      await tester.pumpWidget(const TradingViewExample());
      await tester.pumpAndSettle();

      final rebuiltWidget = tester.widget<TradingViewWidget>(
        find.byType(TradingViewWidget),
      );

      // 验证配置一致
      expect(rebuiltWidget.data.symbol, initialWidget.data.symbol);
      expect(rebuiltWidget.data.locale, initialWidget.data.locale);
    });

    // 不同屏幕尺寸测试
    testWidgets('在不同屏幕尺寸下正常渲染', (WidgetTester tester) async {
      // 测试小屏幕
      tester.binding.window.physicalSizeTestValue = const Size(320, 480);
      await tester.pumpWidget(const TradingViewExample());
      await tester.pumpAndSettle();
      expect(find.byType(TradingViewWidget), findsOneWidget);

      // 重置尺寸
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    });
  });
}
