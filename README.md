# TradingView Flutter

[![Pub Version](https://img.shields.io/pub/v/trading_view_flutter)](https://pub.dev/packages/trading_view_flutter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?logo=Flutter&logoColor=white)](https://flutter.dev)

一个高性能的 Flutter TradingView 图表集成库，提供完整的 TradingView 高级图表功能，支持股票、加密货币、外汇等多种金融产品的技术分析。

## 📋 目录

- [功能特性](#-功能特性)
- [安装指南](#-安装指南)
- [快速开始](#-快速开始)
- [API 文档](#-api-文档)
- [开发指南](#-开发指南)
- [常见问题](#-常见问题)
- [许可证](#-许可证)
- [版本历史](#-版本历史)

## ✨ 功能特性

### 核心功能
- 📊 **完整 TradingView 图表** - 集成 TradingView 高级图表组件
- 🎨 **主题支持** - 支持明暗两种主题模式（Light/Dark）
- 🌐 **多语言支持** - 内置多语言本地化支持
- ⚡ **高性能** - 基于 WebView 的高性能渲染
- 📱 **响应式设计** - 完美适配移动端和桌面端

### 图表配置
- **时间间隔** - 支持日线(D)、月线(M)、年线(Y)等多种时间周期
- **技术指标** - 内置多种常用技术指标
- **绘图工具** - 丰富的图表绘图工具
- **样式定制** - 可自定义图表样式和颜色主题
- **交互控制** - 支持手势交互和工具栏控制

## 📦 安装指南

### 环境要求
- **Flutter**: >= 1.17.0
- **Dart**: >= 2.12.0
- **iOS**: >= 11.0
- **Android**: >= API 21

### 安装依赖

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  trading_view_flutter: ^0.0.1
```

然后运行：

```bash
flutter pub get
```

### iOS 配置

在 `ios/Runner/Info.plist` 中添加网络权限：

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

### Android 配置

在 `android/app/src/main/AndroidManifest.xml` 中添加网络权限：

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

## 🚀 快速开始

### 基础用法

```dart
import 'package:flutter/material.dart';
import 'package:trading_view_flutter/trading_view_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('TradingView Example')),
        body: const TradingViewExample(),
      ),
    );
  }
}

class TradingViewExample extends StatelessWidget {
  const TradingViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    final tradingData = TradingViewData(
      id: 0,
      symbol: 'SZSE:002594',  // 股票代码
      autosize: true,         // 自动调整大小
      interval: TradingViewInterval.M,  // 月线图
      timezone: 'Asia/Shanghai',  // 时区
      theme: TradingViewTheme.light,  // 明亮主题
      style: '1',              // 图表样式
      locale: 'zh',           // 中文界面
      hideTopToolbar: true,   // 隐藏顶部工具栏
      allowSymbolChange: false, // 禁止切换品种
      saveImage: false,       // 禁用保存图片
      showCalendar: true,     // 显示日历
      hideVolume: false,      // 显示成交量
    );

    return TradingViewWidget(data: tradingData);
  }
}
```

### 预期输出

运行上述代码后，你将看到一个完整的 TradingView 图表，显示指定股票的月线图，包含以下特性：
- 中文界面显示
- 明亮主题配色
- 完整的K线图表
- 技术指标显示
- 交互式图表操作

## 📚 API 文档

### TradingViewData 配置类

#### 属性说明

| 参数 | 类型 | 必需 | 默认值 | 描述 |
|------|------|------|--------|------|
| `id` | `int` | ✅ | - | 图表唯一标识符 |
| `symbol` | `String` | ✅ | - | 交易品种代码（如：SZSE:002594） |
| `autosize` | `bool` | ❌ | `true` | 是否自动调整大小 |
| `interval` | `TradingViewInterval` | ❌ | `D` | 时间间隔（D=日, M=月, Y=年） |
| `timezone` | `String` | ❌ | `Etc/UTC` | 时区设置 |
| `theme` | `TradingViewTheme` | ❌ | `light` | 主题模式（light/dark） |
| `style` | `String` | ❌ | `1` | 图表样式 |
| `locale` | `String` | ❌ | `zh` | 语言设置 |
| `hideTopToolbar` | `bool` | ❌ | `false` | 是否隐藏顶部工具栏 |
| `allowSymbolChange` | `bool` | ❌ | `true` | 是否允许切换品种 |
| `saveImage` | `bool` | ❌ | `false` | 是否允许保存图片 |
| `showCalendar` | `bool` | ❌ | `false` | 是否显示日历 |
| `hideVolume` | `bool` | ❌ | `false` | 是否隐藏成交量 |
| `supportHost` | `String` | ❌ | TradingView URL | 支持的主机地址 |

#### 枚举类型

**TradingViewInterval** - 时间间隔枚举
```dart
enum TradingViewInterval {
  D, // 每日
  M, // 每月
  Y, // 每年
}
```

**TradingViewTheme** - 主题枚举
```dart
enum TradingViewTheme { light, dark }
```

### TradingViewWidget 组件

#### 构造函数

```dart
TradingViewWidget({
  Key? key,
  double width = 1200,    // 图表宽度
  double height = 600,    // 图表高度
  required TradingViewData data,  // 图表配置数据
})
```

#### 使用示例

```dart
// 创建自定义大小的图表
TradingViewWidget(
  width: 800,
  height: 400,
  data: TradingViewData(
    id: 1,
    symbol: 'BTCUSDT',
    theme: TradingViewTheme.dark,
  ),
)
```

### TradingViewEmbedder 嵌入器

#### 核心方法

```dart
Future<void> onLoad({
  required TradingViewData tradingViewData,
  void Function(int)? onProgress,           // 加载进度回调
  void Function(String)? onPageFinished,    // 页面加载完成回调
  void Function(HttpResponseError)? onHttpError,         // HTTP错误回调
  void Function(WebResourceError)? onWebResourceError,   // 资源错误回调
  FutureOr<NavigationDecision> Function(NavigationRequest request)? onNavigationRequest, // 导航请求回调
})
```

## 🔧 开发指南

### 本地开发环境搭建

1. **克隆项目**
```bash
git clone https://github.com/ctkqiang/trading_view_flutter.git
cd trading_view_flutter
```

2. **安装依赖**
```bash
flutter pub get
```

3. **运行示例**
```bash
cd example
flutter run
```

### 测试运行

运行所有测试：
```bash
flutter test
```

运行特定测试文件：
```bash
flutter test test/src/trading_view_embedder_test.dart
```

### 代码规范

- 遵循 [Dart 风格指南](https://dart.dev/guides/language/effective-dart/style)
- 使用 [Flutter Lints](https://pub.dev/packages/flutter_lints) 进行代码检查
- 提交前运行 `flutter analyze` 和 `flutter test`

### 贡献指南

1. Fork 项目
2. 创建特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 创建 Pull Request

## ❓ 常见问题

### Q: 图表无法加载怎么办？
**A:** 检查网络连接，确保有访问 TradingView 服务的权限。

### Q: 如何自定义图表样式？
**A:** 通过 `TradingViewData` 的 `style` 参数和 `theme` 参数进行定制。

### Q: 支持哪些交易品种？
**A:** 支持所有 TradingView 支持的品种，包括股票、加密货币、外汇、指数等。

### Q: 如何添加技术指标？
**A:** 目前需要通过 TradingView 原生的指标添加功能，后续版本将提供编程接口。

### 兼容性说明

- ✅ Flutter 2.x & 3.x
- ✅ iOS 11.0+
- ✅ Android API 21+
- ✅ Web (需要配置 CORS)
- ✅ Desktop (Windows, macOS, Linux)

### 性能优化建议

1. **避免频繁重建** - 将 `TradingViewWidget` 放在 `StatefulWidget` 中
2. **使用 const 构造函数** - 对不变的配置使用 const
3. **合理设置尺寸** - 避免不必要的布局重计算
4. **内存管理** - 在页面销毁时正确释放资源

## 📄 许可证

本项目采用 **MIT 许可证** - 查看 [LICENSE](LICENSE) 文件了解详情。

```
MIT License

Copyright (c) 2026 TradingView Flutter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 📈 版本历史

### v0.0.1 (2024-12-08)
- ✅ 初始版本发布
- ✅ 基础 TradingView 图表集成
- ✅ 明暗主题支持
- ✅ 多语言界面
- ✅ 响应式布局
- ✅ 基础技术指标

### 即将到来
- 🔄 更多技术指标 API
- 🔄 自定义绘图工具
- 🔄 实时数据流支持
- 🔄 性能优化改进

---

## 🤝 支持与贡献

如果你遇到任何问题或有改进建议，请：

1. 查看 [常见问题](#-常见问题)
2. 搜索 [现有 Issues](https://github.com/your-username/trading_view_flutter/issues)
3. 创建 [新 Issue](https://github.com/your-username/trading_view_flutter/issues/new)

欢迎提交 Pull Request 来帮助改进这个项目！

<div align="center">

**如果这个项目对你有帮助，请给它一个 ⭐️ 星标！**

</div>

--- 

### 🌐 全球捐赠通道

#### 国内用户

<div align="center" style="margin: 40px 0">

<div align="center">
<table>
<tr>
<td align="center" width="300">
<img src="https://github.com/ctkqiang/ctkqiang/blob/main/assets/IMG_9863.jpg?raw=true" width="200" />
<br />
<strong>🔵 支付宝</strong>（小企鹅在收金币哟~）
</td>
<td align="center" width="300">
<img src="https://github.com/ctkqiang/ctkqiang/blob/main/assets/IMG_9859.JPG?raw=true" width="200" />
<br />
<strong>🟢 微信支付</strong>（小绿龙在收金币哟~）
</td>
</tr>
</table>
</div>
</div>

#### 国际用户

<div align="center" style="margin: 40px 0">
  <a href="https://qr.alipay.com/fkx19369scgxdrkv8mxso92" target="_blank">
    <img src="https://img.shields.io/badge/Alipay-全球支付-00A1E9?style=flat-square&logo=alipay&logoColor=white&labelColor=008CD7">
  </a>
  
  <a href="https://ko-fi.com/F1F5VCZJU" target="_blank">
    <img src="https://img.shields.io/badge/Ko--fi-买杯咖啡-FF5E5B?style=flat-square&logo=ko-fi&logoColor=white">
  </a>
  
  <a href="https://www.paypal.com/paypalme/ctkqiang" target="_blank">
    <img src="https://img.shields.io/badge/PayPal-安全支付-00457C?style=flat-square&logo=paypal&logoColor=white">
  </a>
  
  <a href="https://donate.stripe.com/00gg2nefu6TK1LqeUY" target="_blank">
    <img src="https://img.shields.io/badge/Stripe-企业级支付-626CD9?style=flat-square&logo=stripe&logoColor=white">
  </a>
</div>

---

### 📌 开发者社交图谱

#### 技术交流

<div align="center" style="margin: 20px 0">
  <a href="https://github.com/ctkqiang" target="_blank">
    <img src="https://img.shields.io/badge/GitHub-开源仓库-181717?style=for-the-badge&logo=github">
  </a>
  
  <a href="https://stackoverflow.com/users/10758321/%e9%92%9f%e6%99%ba%e5%bc%ba" target="_blank">
    <img src="https://img.shields.io/badge/Stack_Overflow-技术问答-F58025?style=for-the-badge&logo=stackoverflow">
  </a>
  
  <a href="https://www.linkedin.com/in/ctkqiang/" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-职业网络-0A66C2?style=for-the-badge&logo=linkedin">
  </a>
</div>

#### 社交互动

<div align="center" style="margin: 20px 0">
  <a href="https://www.instagram.com/ctkqiang" target="_blank">
    <img src="https://img.shields.io/badge/Instagram-生活瞬间-E4405F?style=for-the-badge&logo=instagram">
  </a>
  
  <a href="https://twitch.tv/ctkqiang" target="_blank">
    <img src="https://img.shields.io/badge/Twitch-技术直播-9146FF?style=for-the-badge&logo=twitch">
  </a>
  
  <a href="https://github.com/ctkqiang/ctkqiang/blob/main/assets/IMG_9245.JPG?raw=true" target="_blank">
    <img src="https://img.shields.io/badge/微信公众号-钟智强-07C160?style=for-the-badge&logo=wechat">
  </a>
</div>
