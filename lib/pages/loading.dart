import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(child: CircularProgressIndicator()), color: Colors.white);
  }
}
