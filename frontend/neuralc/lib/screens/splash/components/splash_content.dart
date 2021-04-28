import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.image,
    this.text,
  }) : super(key: key);

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Text(
          'NeuralC',
          style: TextStyle(
            fontSize: SizeConfig.getProportionateScreenWidth(46),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        Spacer(),
        Image.asset(
          image,
          height: SizeConfig.getProportionateScreenHeight(310), //265
          width: SizeConfig.getProportionateScreenWidth(360), //235
        )
      ],
    );
  }
}
