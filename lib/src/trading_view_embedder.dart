import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trading_view_flutter/src/model/theme.dart';
import 'package:trading_view_flutter/src/model/trading_view_data.dart';
import 'package:trading_view_flutter/src/trading_view_js_interopt.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradingViewEmbedder {
  static TradingViewEmbedder get instance => TradingViewEmbedder.create();

  TradingViewEmbedder._();
  TradingViewEmbedder.create() : this._();

  late WebViewController controller;

  @mustCallSuper
  Future<void> onLoad({
    required TradingViewData tradingViewData,
    void Function(int)? onProgress,
    void Function(String)? onPageFinished,
    void Function(HttpResponseError)? onHttpError,
    void Function(WebResourceError)? onWebResourceError,
    FutureOr<NavigationDecision> Function(NavigationRequest request)?
    onNavigationRequest,
  }) async {
    assert(tradingViewData.toJson().isNotEmpty, 'TradingViewData 不可为空');

    final tradingViewWCode = TradingViewJsInteropt.getTradingViewWCode(
      json: tradingViewData.toJson(),
      isLightWeightChart: tradingViewData.isLightWeightChart,
    );

    if (kDebugMode) {
      debugPrint('TradingViewWCode: $tradingViewWCode');
    }

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(
        tradingViewData.theme == TradingViewTheme.dark
            ? Colors.black
            : Colors.white,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: onProgress,
          onPageFinished: onPageFinished,
          onHttpError: onHttpError,
          onWebResourceError: onWebResourceError,
          onNavigationRequest: onNavigationRequest,
        ),
      )
      ..loadRequest(
        Uri.parse(
          Uri.dataFromString(
            tradingViewWCode,
            mimeType: 'text/html',
            encoding: Encoding.getByName('utf-8'),
          ).toString(),
        ),
      );
  }
}
