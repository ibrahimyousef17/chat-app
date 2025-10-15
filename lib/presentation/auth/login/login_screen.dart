import 'package:chat_app/domain/di.dart';
import 'package:chat_app/presentation/auth/login/cubit/login_state.dart';
import 'package:chat_app/presentation/auth/register/register_screen.dart';
import 'package:chat_app/presentation/utils/app_assets.dart';
import 'package:chat_app/presentation/utils/app_theme.dart';
import 'package:chat_app/presentation/utils/text_form_field_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/home_screen.dart';
import '../../utils/dialog_utils.dart';
import 'cubit/login_view_model.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'LoginScreen';
  var viewModel = LoginViewModel(loginUseCase: injectLoginUseCase());
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
                'Login',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            body: BlocListener<LoginViewModel, LoginStates>(
              bloc: viewModel,
              listener: (context, state) {
                // TODO: implement listener
                if (state is LoginLoadingState) {
                  DialogUtils.showLoading(context);
                } else if (state is LoginErrorState) {
                  DialogUtils.hideLoading(context);
                  DialogUtils.showMessage(
                      context: context,
                      title: 'Error',
                      message: state.errorMessage,
                      barrierDismissible: false,
                      posActionName: 'ok',
                      );
                } else {
                  DialogUtils.hideLoading(context);
                  DialogUtils.showMessage(
                      context: context,
                      title: 'Success',
                      message: "Login successfully",
                      barrierDismissible: false,
                      posActionName: 'ok',posActon: (){
                    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                  });
                }
              },
              child: Padding(
                padding: EdgeInsets.all(20.h),
                child: Form(
                  key: viewModel.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                        ),
                        Text(
                          'Welcome Back!',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 36.h,
                        ),
                        TextFormFieldItem(
                          textName: 'Email',
                          hintText: 'Please enter your email',
                          controller: viewModel.emailController,
                          validator: (email) {
                            if (email == null || email.trim().isEmpty) {
                              return 'please enter your email';
                            }
                            final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(email);
                            if (!emailValid) {
                              return 'Please valid email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        TextFormFieldItem(
                          textName: 'Password',
                          hintText: 'Please enter your password',
                          controller: viewModel.passwordController,
                          validator: (password) {
                            if (password == null || password.trim().isEmpty) {
                              return 'please enter your password';
                            }
                            if (password.length < 6) {
                              return 'password must be 6 numbers';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor),
                            onPressed: () {
                              //todo: login
                              viewModel.login();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontSize: 18.sp),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 30.sp,
                                  color: Colors.white,
                                )
                              ],
                            )),
                        SizedBox(
                          height: 30.h,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RegisterScreen.routeName);
                            },
                            child: Text(
                              'Or Create My Account',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontSize: 18.sp,
                                      color: AppTheme.primaryColor),
                            ))
                      ],
                    ),
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
