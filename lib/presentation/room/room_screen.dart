import 'package:flutter/material.dart';

import '../utils/app_assets.dart';
import '../utils/app_theme.dart';

class RoomScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppTheme.whiteColor,
        child: Stack(
          children: [
          Image.asset(
          AppAssets.mainBackground,
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Scaffold(
        appBar: AppBar(
        title: Text('Chat App',
    style: Theme.of(context).textTheme.titleMedium,
    ),
    ),
    )]));
  }
}
