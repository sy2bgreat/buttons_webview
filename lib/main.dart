import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  String siteName = "www.naver.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Center(
          child: Column(
            children: [
              const Text("Web View"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          setState(() {
                            siteName = "www.google.com";
                          });
                          _reloadSite();
                        },
                        child: const Text("Google")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                        onPressed: () {
                          setState(() {
                            siteName = "www.naver.com";
                          });
                          _reloadSite();
                        },
                        child: const Text("Naver")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () {
                          setState(() {
                            siteName = "www.daum.net";
                          });
                          _reloadSite();
                        },
                        child: const Text("Daum")),
                  ),
                ],
              )
            ],
          ),
        ),
        toolbarHeight: 100,
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: "https://$siteName",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          )
        ],
      ),
      floatingActionButton: FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              child: const Icon(Icons.arrow_back),
              onPressed: () {
                controller.data!.goBack();
              },
            );
          }
          return Stack();
        },
      ),
    );
  }

  _reloadSite() {
    // _controller.future.then((value) => value.loadUrl("https:://$siteName"));
    _controller.future.then((value) {
      value.loadUrl("https://$siteName");
    });
  }
}
