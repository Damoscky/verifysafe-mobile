import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verifysafe/core/data/enum/view_state.dart';
import 'package:verifysafe/core/data/view_models/billing_view_model.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:verifysafe/ui/widgets/bottom_sheets/payment_successful.dart';
import 'package:verifysafe/ui/widgets/show_flush_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'app_loader.dart';
import 'custom_appbar.dart';

class InAppWebView extends ConsumerStatefulWidget {
  final String url;
  final String title;
  const InAppWebView({super.key, required this.url, required this.title});

  @override
  ConsumerState<InAppWebView> createState() => _InAppWebViewState();
}

class _InAppWebViewState extends ConsumerState<InAppWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      initControllerDynamics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: widget.title,
        context: context,
        // textColor: ColorPath.shaftBlack
      ),
      body: _isLoading
          ? Center(child: AppLoader(size: 80))
          : WebViewWidget(controller: _controller),
    );
  }

  initControllerDynamics() {
    final billingVm = ref.watch(billingViewModel);
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onUrlChange: (change) async {
            if (change.url != null) {
              if (change.url!.contains('complete-subscription')) {
                setState(() {
                  _isLoading = true;
                });
                await billingVm.completeSubscriptionPayment();

                if (billingVm.thirdState == ViewState.retrieved) {
                  setState(() {
                    _isLoading = false;
                  });
                  baseBottomSheet(
                    context: context,
                    isDismissible: false,
                    enableDrag: false,
                    content: PaymentSuccessful(),
                  );
                } else {
                  showFlushBar(
                    context: context,
                    message: billingVm.message,
                    success: false,
                  );
                }
              }
            }
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(Uri.parse(widget.url));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }
}
