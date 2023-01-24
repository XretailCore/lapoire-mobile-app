import 'package:flutter/material.dart';
import 'package:imtnan/core/utils/theme.dart';

class FavoriateButtonWidget extends StatefulWidget {
  const FavoriateButtonWidget({
    Key? key,
    required this.defaultValue,
    required this.onFavoraite,
    this.iconSize = 18.0, this.isInner=false,
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
     Color primaryColor = widget.isInner?Colors.white:CustomThemes.appTheme.primaryColor;
    return InkWell(
      onTap: () {
        final changeFavoriateValue = !isFavoraite;
        widget.onFavoraite(changeFavoriateValue);
      },
      child: Icon(
        isFavoraite ? Icons.favorite : Icons.favorite_border,
        size: widget.iconSize,
        color: primaryColor,
      ),
    );
  }
}
