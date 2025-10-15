
import 'package:chat_app/presentation/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogUtils {
  static void hideLoading(BuildContext context){
    Navigator.of(context).pop();
  }
  static void showLoading(BuildContext context){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context)=>AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(color: AppTheme.primaryColor,),
              SizedBox(width: 8.w,),
              Text('Loading',style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.blackColor
              ),)
            ],
          ),
        ));
  }
  static void showMessage({required BuildContext context,required String title,required String message ,
    String? posActionName, Function? posActon, String? negActionName , Function? negAction,bool barrierDismissible=true}){
    List<Widget> action = [] ;
    if(posActionName!=null){
      action.add(ElevatedButton(
          onPressed: (){
            Navigator.of(context).pop();
            if(posActon!=null){
              posActon.call() ;
            }


          },
          child: Text(posActionName,style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 18.sp
          ),)));
    }
    if(negActionName!=null){
      action.add(ElevatedButton(
          onPressed: (){
            Navigator.of(context).pop();
            if(negAction!=null){
              negAction.call() ;
            }
          },
          child: Text(negActionName,style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 18.sp
          ),)));
    }
    showDialog(
      barrierDismissible: barrierDismissible,
        context: context,
        builder: (context)=>AlertDialog(
          title: Text(title,style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppTheme.blackColor
          ),),
          content:Text(message,style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.blackColor,
            fontSize: 18.sp
          ),maxLines: 2,overflow: TextOverflow.ellipsis,) ,
          actions:action,
        ));
  }
}