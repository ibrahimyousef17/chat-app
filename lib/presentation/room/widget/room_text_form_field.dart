import 'package:chat_app/presentation/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomTextField extends StatelessWidget {
String hintText ;
String? Function(String?)? validator ;
TextEditingController? controller ;
int maxLines ;
RoomTextField({
  required this.hintText,
  this.validator,
  required this.controller, this.maxLines=1
});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontSize: 18.sp,
        color: AppTheme.blackColor
      ),
      validator: validator,
      controller: controller,
      maxLines: maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w400
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2.w
          )
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blue,
                width: 2.w
            )
        ),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red,
                width: 2.w
            )
        ),
        focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blue,
                width: 2.w
            )
        ),
      ),
    );
  }
}
