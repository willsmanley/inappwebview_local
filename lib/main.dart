import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(
              color: Colors.blue,
              width: 5,
            ),
          ),
          child: InAppWebView(
            initialFile: "assets/index.html",
            initialSettings: InAppWebViewSettings(
              allowFileAccessFromFileURLs: true,
              allowUniversalAccessFromFileURLs: true,
            ),
            onConsoleMessage: (controller, consoleMessage) {
              print('webview console message: $consoleMessage');
            },
            onWebViewCreated: (controller) async {
              print('webview created');
            },
            onLoadStop: (controller, url) {
              Future.delayed(Duration(seconds: 3), () {
                controller.evaluateJavascript(source: """
                  console.log('html content:', document.documentElement.outerHTML);
                  """);
              });
            },
          ),
        ),
      ),
    );
  }
}
