import 'package:flutter/material.dart';

class FavoriateButtonWidget extends StatefulWidget {
  const FavoriateButtonWidget({
    Key? key,
    required this.defaultValue,
    required this.onFavoraite,
    this.iconSize = 18.0,
  }) : super(key: key);
  final bool defaultValue;
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
    final Color primaryColor = Theme.of(context).primaryColor;
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
