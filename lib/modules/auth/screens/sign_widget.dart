import 'package:imtnan/core/components/custom_appbar.dart';
import '../widgets/signup_widget.dart';
import '../../../core/localization/translate.dart';
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
      appBar: CustomAppBar(
        showBackButton: true,
        title:
            initialLabelIndex == 0 ? Translate.login.tr : Translate.createAccount.tr,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
