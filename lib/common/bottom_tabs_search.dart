import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BottomTabsSearch extends StatelessWidget {
  const BottomTabsSearch(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return
            Container(
          height: 70,
          child: Material(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    icon: Image.asset('assets/Icons/home.png'),
                    onPressed: () => controller
                        .loadUrl('https://partners.travezl.com/activetravel')),
                IconButton(
                  icon: Image.asset('assets/Icons/save.png'),
                  onPressed: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(
                          '/home', (Route<dynamic> route) => false),
                ),
                IconButton(
                  icon: Image.asset('assets/Icons/left.png'),
                  onPressed: !webViewReady
                      ? null
                      : () => navigate(context, controller, goBack: true),
                ),
                IconButton(
                  icon: Image.asset('assets/Icons/right.png'),
                  onPressed: !webViewReady
                      ? null
                      : () => navigate(context, controller, goBack: false),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  navigate(BuildContext context, WebViewController controller,
      {bool goBack: false}) async {
    bool canNavigate =
        goBack ? await controller.canGoBack() : await controller.canGoForward();
    if (canNavigate) {
      goBack ? controller.goBack() : controller.goForward();
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text("No ${goBack ? 'back' : 'forward'} history item")),
      );
    }
  }
}