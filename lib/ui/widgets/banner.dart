import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner(this.bannerHeight, {Key? key}) : super(key: key);
  final double bannerHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: bannerHeight,
      child: Image.network(
          "https://thumbs.dreamstime.com/b/hong-kong-january-design-fendi-store-elements-shopping-mall-italian-luxury-fashion-house-whose-specialities-include-102933721.jpg",
          fit: BoxFit.cover),
    );
  }
}
