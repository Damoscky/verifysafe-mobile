import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';

import '../../../core/constants/color_path.dart';

class Terms extends StatelessWidget {
  final TextAlign? textAlign;
  const Terms({super.key, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return  RichText(
      textAlign: textAlign ?? TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w400,
          color: ColorPath.stormGrey,
        ),
        children: [
          const TextSpan(
            text: 'By continuing, you agree to our ',
          ),
          TextSpan(
            text: 'Terms of Service',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.textPrimary
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                // pushNavigation(context: context,
                //     widget: const InAppWebView(
                //         url: terms,
                //         title: 'Privacy Policy'
                //     ),
                //     routeName: NamedRoutes.inAppWebView
                // );
              },
          ),
          const TextSpan(
            text: ' and ',
          ),
          TextSpan(
            text: 'Data Policy.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.textPrimary
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                /*pushNavigation(context: context,
                                                        widget: const InAppWebView(
                                                            url: terms,
                                                            title: 'Terms and Game Rules'
                                                        ),
                                                        routeName: NamedRoutes.inAppWebView
                                                    );*/
              },
          ),

        ],
      ),
    );
  }
}
