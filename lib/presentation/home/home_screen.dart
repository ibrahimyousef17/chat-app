import 'package:chat_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:chat_app/presentation/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_assets.dart';
import '../utils/app_theme.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName ='Home Screen';

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
      title: Text(
      AuthViewModel.getProvider(context).currentUser!.name??'',
      style: Theme.of(context).textTheme.titleMedium,
    ),
        actions: [
          IconButton(onPressed: () async {
            //todo: back to login
            AuthViewModel.getProvider(context).clearUser();
            Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
          }, icon: Icon(Icons.logout,size: 30.sp,color: AppTheme.whiteColor,))
        ],
    ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.primaryColor,
          shape: CircleBorder(

          ),
            onPressed: (){
          //todo: navigate to create room screen
        },
          child: Icon(Icons.add,size: 30.sp,),
        ),
    )]));
  }
}
