import 'package:chat_app/presentation/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldItem extends StatefulWidget {
String hintText ;
TextEditingController controller ;
String? Function(String?)? validator ;
TextInputType keyboardType ;
bool obscureText ;
String textName ;
TextFormFieldItem({
  required this.hintText,
  required this.controller,
  required this.validator,
  required this.textName,
  this.obscureText= false,
  this.keyboardType= TextInputType.text,
});

  @override
  State<TextFormFieldItem> createState() => _TextFormFieldItemState();
}

class _TextFormFieldItemState extends State<TextFormFieldItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.textName,style: Theme.of(context).textTheme.titleSmall,),
        SizedBox(height: 12.h,),
        TextFormField(
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppTheme.primaryColor,
            fontSize: 14.sp
          ),
          keyboardType:widget.keyboardType ,
          controller: widget.controller,
          validator:widget.validator ,
          obscureText: widget.obscureText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.textName =='Password'?
            IconButton(
                onPressed: (){
                  widget.obscureText = !widget.obscureText ;
                  setState(() {

                  });
                },
                icon: Icon(
              widget.obscureText?Icons.visibility:Icons.visibility_off,size: 30.sp,color: Colors.grey,
            )): null,
            hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2.w
              )
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red,            width: 2.w
              )
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppTheme.primaryColor,
                  width: 2.w

              )
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                  width: 2.w

              )
            ),
          ),
        ),
      ],
    );
  }
}
