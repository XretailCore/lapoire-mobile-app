import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalCardShimmerLoader extends StatelessWidget {
  const HorizontalCardShimmerLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(.3),
      highlightColor: Colors.grey.withOpacity(.1),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Column(
                children: List.generate(
                    10,
                    (index) => Container(
                          width: double.infinity,
                          height: 170.0,
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 200,
                                height: 200.0,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: Column(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 17.0,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width: 90,
                                    height: 17.0,
                                    color: Colors.white,
                                  ),
                                ],
                              ))
                            ],
                          ),
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
