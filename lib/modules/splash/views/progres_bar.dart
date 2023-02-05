import 'dart:async';

import 'package:cowpay/core/helpers/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/theme.dart';

class ProgressBarCustom extends StatefulWidget {
  const ProgressBarCustom({Key? key}) : super(key: key);

  @override
  State<ProgressBarCustom> createState() => _ProgressBarCustomState();
}

class _ProgressBarCustomState extends State<ProgressBarCustom> {
  double _progressValue = 0;
  bool selected = false;

  @override
  void initState() {
    super.initState();
    _progressValue = 0.0;

    _updateProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                width: .4.sw,
                height: 35,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      curve: Curves.linear,
                      duration: const Duration(milliseconds: 800),
                      left: selected ? .29.sw : -100,
                      child: SvgPicture.asset(
                        'assets/images/la_splash.svg',
                        height: 35,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                width: 18,
                height: .5.sh,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        curve: Curves.bounceOut,
                        duration: const Duration(milliseconds: 1000),
                        top: selected ? .20.sh : -.5.sw,
                        child: SvgPicture.asset(
                          'assets/images/logo_splash.svg',
                          height: 50,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                width: .5.sw,
                height: 35,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      curve: Curves.linear,
                      duration: const Duration(milliseconds: 800),
                      right: selected ? .28.sw : -100.0,
                      child: SvgPicture.asset(
                        'assets/images/poire_splash.svg',
                        height: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 50, 0, 0),
          child: SizedBox(
            width: .43.sw,
            child: Center(
                child: LinearProgressIndicator(
              minHeight: 6,
              backgroundColor: AppColors.highlighter,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.redColor),
              value: _progressValue,
            )),
          ),
        ),
        Container(
          color: Colors.white,
          width: double.infinity,
          height: 35,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              AnimatedPositioned(
                curve: Curves.linear,
                duration: const Duration(milliseconds: 800),
                bottom: selected ? 0 : -100.0,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomText(
                    'Powered By Link TSP',
                    style: TextStyle(
                        color: CustomThemes.appTheme.primaryColor,
                        fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _updateProgress() {
    const oneSec = Duration(milliseconds: 500);
    Timer.periodic(oneSec, (Timer t) {
      if (mounted) {
        setState(() {
          selected = true;
          _progressValue += 0.4;
          if (_progressValue.toStringAsFixed(1) == '1.0') {
            t.cancel();

            return;
          }
        });
      }
    });
  }
}
