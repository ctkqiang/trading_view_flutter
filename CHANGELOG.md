# TradingView Flutter Changelog


## [0.0.1] 

- 初始版本发布，集成了 TradingView 高级图表功能。
- 支持明亮（Light）和黑暗（Dark）主题模式。
- 提供多语言（Locale）配置选项。
- 实现了基于 `WebView` 的高性能图表渲染。
- 引入 `TradingViewData` 配置类，用于灵活定制图表参数，包括 `symbol`（交易品种）、`interval`（时间间隔）、`timezone`（时区）等。
- 提供了 `TradingViewWidget` 组件，方便在 Flutter 应用中嵌入图表。
- 包含了 `TradingViewEmbedder` 和 `TradingViewJsInteropt`，用于处理 WebView 逻辑和 JavaScript 交互。
