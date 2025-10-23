import 'package:chat_app/presentation/utils/app_assets.dart';
import 'package:chat_app/presentation/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomItem extends StatelessWidget {
  String roomTitle ;
  String categoryId;
  RoomItem({required this.roomTitle,required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: AppTheme.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            categoryId=='sports'?
            'assets/images/sports_icon.png':
            categoryId=='music'?
                'assets/images/music_icon.png':
                'assets/images/film_icon.png'

            ,height:80.h ,width: 80.w,fit: BoxFit.fill,),
          SizedBox(height: 8.h,),
          Text(roomTitle,style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppTheme.blackColor
          ),)
        ],
      ),
    );
  }
}
