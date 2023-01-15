import '../widgets/header_sign_widget.dart';
import '../widgets/signup_widget.dart';

import '../../../core/localization/translate.dart';
import '../../../core/components/appbar_widget.dart';

import 'package:flutter/material.dart';

import '../widgets/signin_widget.dart';

class SignWidget extends StatefulWidget {
  const SignWidget({Key? key}) : super(key: key);

  @override
  State<SignWidget> createState() => _SignWidgetState();
}

class _SignWidgetState extends State<SignWidget> {
  int initialLabelIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title:
            initialLabelIndex == 0 ? Translate.signIn.tr : Translate.signUp.tr,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HeaderSignWidget(
            labels: [Translate.signIn.tr, Translate.signUp.tr],
            initialLabelIndex: initialLabelIndex,
            onToggle: (v) {
              setState(() {
                initialLabelIndex = v ?? 0;
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: initialLabelIndex == 0
                  ? SignInWidget(
                      onTapGoToSignUp: () {
                        setState(
                          () {
                            initialLabelIndex = 1;
                          },
                        );
                      },
                    )
                  : Signupwidget(
                      onTapGoToSignIn: () {
                        setState(
                          () {
                            initialLabelIndex = 0;
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
