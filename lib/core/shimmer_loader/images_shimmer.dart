import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImagesShimmerLoader extends StatelessWidget {
  final double? height;
  final double? width;
  final double radius;
  const ImagesShimmerLoader({
    Key? key,
    this.height = 120,
    this.width = 120,
    this.radius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(.3),
      highlightColor: Colors.grey.withOpacity(.1),
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Image.asset(
          "assets/images/logo.png",
          color: Colors.black,
        ),
      ),
    );
  }
}
