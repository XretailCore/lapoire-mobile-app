import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imtnan/core/utils/theme.dart';

import '../../../core/utils/app_colors.dart';

class FavoriateButtonWidget extends StatefulWidget {
  const FavoriateButtonWidget({
    Key? key,
    required this.defaultValue,
    required this.onFavoraite,
    this.iconSize = 18.0,
    this.isInner = false,
  }) : super(key: key);
  final bool defaultValue;
  final bool isInner;
  final double iconSize;
  final void Function(bool isFavoriate) onFavoraite;

  @override
  State<FavoriateButtonWidget> createState() => _FavoriateButtonWidgetState();
}

class _FavoriateButtonWidgetState extends State<FavoriateButtonWidget> {
  late bool isFavoraite;
  @override
  void initState() {
    super.initState();
    isFavoraite = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor =
        widget.isInner ? Colors.white : CustomThemes.appTheme.primaryColor;
    return InkWell(
      highlightColor: AppColors.highlighter,
      customBorder: const CircleBorder(),
      onTap: () {
        final changeFavoriateValue = !isFavoraite;
        widget.onFavoraite(changeFavoriateValue);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FaIcon(
          isFavoraite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
          size: widget.iconSize,
          color: primaryColor,
        ),
      ),
    );
  }
}
