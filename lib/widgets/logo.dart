import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, this.height});
  final double? height  ;

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset('assets/logo.png', height : height??100));
  }
}