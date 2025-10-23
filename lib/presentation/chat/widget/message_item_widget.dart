import 'package:chat_app/domain/entity/message.dart';
import 'package:chat_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MessageItemWidget extends StatefulWidget {
MessageEntity messageEntity;
MessageItemWidget({required this.messageEntity});

  @override
  State<MessageItemWidget> createState() => _MessageItemWidgetState();
}

class _MessageItemWidgetState extends State<MessageItemWidget> {

  @override
  Widget build(BuildContext context) {
    String currentUserId = AuthViewModel.getProvider(context).currentUser?.id??'';
    String userMessageId = widget.messageEntity.userId;
    return userMessageId==currentUserId?
      senderMessage():receiveMessage();
  }

  Widget senderMessage(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
                bottomLeft: Radius.circular(20.r)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            color: Colors.blue
          ),
          child: Center(child: Text(widget.messageEntity.content,style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18.sp),)),
        ),
        SizedBox(height: 5.h,),
        Text(DateFormat('jm').format(DateTime.fromMillisecondsSinceEpoch(widget.messageEntity.dateTime)),style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.start,)
      ],
    );
  }
  Widget receiveMessage(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            color: Colors.grey
          ),
          child: Center(child: Text(widget.messageEntity.content,style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18.sp),)),
        ),
        SizedBox(height: 5.h,),
        Text(DateFormat('jm').format(DateTime.fromMillisecondsSinceEpoch(widget.messageEntity.dateTime)),style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.end,)
      ],
    );
  }
}


