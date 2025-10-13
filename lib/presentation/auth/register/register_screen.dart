import 'package:chat_app/domain/di.dart';
import 'package:chat_app/presentation/auth/login/login_screen.dart';
import 'package:chat_app/presentation/utils/app_assets.dart';
import 'package:chat_app/presentation/utils/app_theme.dart';
import 'package:chat_app/presentation/utils/text_form_field_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cubit/register_view_model.dart';
class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register screen';
  var viewModel = RegisterViewModel(registerUseCase: injectRegisterUseCase());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.whiteColor,
      child: Stack(
        children: [
          Image.asset(AppAssets.mainBackground,fit: BoxFit.fill,width: double.infinity,),
          Scaffold(
            appBar: AppBar(
              title: Text('Create Account',style: Theme.of(context).textTheme.titleMedium,),
            ),
            body: Padding(
              padding:  EdgeInsets.all(20.h),
              child: Form(
                key: viewModel.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.25,),
                      TextFormFieldItem(
                        textName: 'User Name',
                        hintText: 'Please enter your name',
                        controller: viewModel.userNameController,
                        validator: (name){
                          if(name==null||name.trim().isEmpty){
                            return 'please enter your email';
                          }
                          return null ;
                        },
                      ),
                      SizedBox(height: 30.h,),
                      TextFormFieldItem(
                        textName: 'Email',
                        hintText: 'Please enter your email',
                        controller: viewModel.emailController,
                        validator: (email){
                          if(email==null||email.trim().isEmpty){
                            return 'please enter your email';
                          }
                          final bool emailValid =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email);
                          if(!emailValid){
                            return 'Please valid email' ;
                          }
                          return null ;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 30.h,),
                      TextFormFieldItem(
                        textName: 'Password',
                        hintText: 'Please enter your password',
                        controller: viewModel.passwordController,
                        validator: (password){
                          if(password==null||password.trim().isEmpty){
                            return 'please enter your password';
                          }
                          if(password.length<6){
                            return 'password must be 6 numbers' ;
                          }
                          return null ;
                        },
                        keyboardType: TextInputType.number,
                        obscureText: true,
                      ),
                      SizedBox(height: 30.h,),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor
                          ),
                          onPressed: (){
                            //todo: register
                          }, child: Row(
                        children: [
                          Text('Create Account',style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: 18.sp
                          ),),
                          Icon(Icons.arrow_forward,size: 30.sp,color: Colors.white,)
                        ],
                      )),
                      SizedBox(height: 30.h,),
                      TextButton(onPressed: (){
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      }, child: Text('I already have an account',style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 18.sp,
                          color: AppTheme.primaryColor
                      ),))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
