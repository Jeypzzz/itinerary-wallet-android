import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:itinerary_wallet/common/bottom_tabs_search.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  num _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: _stackToView,
          children: [
            Column(
              children: [
                Expanded(
                  child: WebView(
                      initialUrl: 'https://partners.travezl.com/activetravel',
                      onWebViewCreated: (WebViewController webViewController) {
                        _controller.complete(webViewController);
                      },
                      javascriptMode: JavascriptMode.unrestricted,
                      onPageFinished: _handleLoad),
                ),
                BottomTabsSearch(_controller.future),
              ],
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
