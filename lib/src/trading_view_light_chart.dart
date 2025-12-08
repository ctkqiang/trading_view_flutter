import 'package:flutter/material.dart';
import 'package:trading_view_flutter/trading_view_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradingViewLightChart extends StatefulWidget {
  final double width;
  final double height;
  final TradingViewData data;

  TradingViewLightChart({
    super.key,
    this.width = 1200,
    this.height = 600,
    required this.data,
  }) : assert(data.toJson().isNotEmpty, 'TradingViewData 不可为空');

  @override
  State<TradingViewLightChart> createState() => _TradingViewLightChartState();
}

class _TradingViewLightChartState extends State<TradingViewLightChart> {
  final tradingViewEmbedder = TradingViewEmbedder.instance;

  @override
  void initState() {
    super.initState();

    tradingViewEmbedder.onLoad(tradingViewData: widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: widget.height,
        width: widget.width,
        child: WebViewWidget(
          key: widget.key,
          controller: tradingViewEmbedder.controller,
        ),
      ),
    );
  }
}
