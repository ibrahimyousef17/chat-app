import 'package:chat_app/domain/di.dart';
import 'package:chat_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:chat_app/presentation/auth/login/login_screen.dart';
import 'package:chat_app/presentation/chat/chat_screen.dart';
import 'package:chat_app/presentation/home/cubit/home_screen_view_model.dart';
import 'package:chat_app/presentation/home/cubit/home_states.dart';
import 'package:chat_app/presentation/home/widget/room_item.dart';
import 'package:chat_app/presentation/room/room_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entity/roomEntity.dart';
import '../utils/app_assets.dart';
import '../utils/app_theme.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'Home Screen';

  var viewModel = HomeScreenViewModel(getRoomUseCase: injectGetRoomUseCase());



  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppTheme.whiteColor,
        child: Stack(children: [
          Image.asset(
            AppAssets.mainBackground,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Scaffold(
            appBar: AppBar(
              title: Text(
                AuthViewModel.getProvider(context).currentUser?.name ?? '',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              actions: [
                IconButton(
                    onPressed: () async {
                      //todo: back to login
                      AuthViewModel.getProvider(context).clearUser();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginScreen.routeName, (route) => false);
                    },
                    icon: Icon(
                      Icons.logout,
                      size: 30.sp,
                      color: AppTheme.whiteColor,
                    ))
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppTheme.primaryColor,
              shape: CircleBorder(),
              onPressed: () {
                //todo: navigate to create room screen
                Navigator.of(context).pushNamed(RoomScreen.routeName);
              },
              child: Icon(
                Icons.add,
                size: 30.sp,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(24.w),
              child: BlocBuilder<HomeScreenViewModel, HomeStates>(
                bloc: viewModel
                  ..getRoomFromFireStore(
                      AuthViewModel.getProvider(context).currentUser?.id ?? ''),
                builder: (context, state) {
                  if (state is GetRoomLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                      ),
                    );
                  } else if (state is GetRoomErrorState) {
                    return Column(
                      children: [
                        Text(
                          state.errorMessage,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppTheme.blackColor),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              viewModel.getRoomFromFireStore(
                                  AuthViewModel.getProvider(context)
                                          .currentUser
                                          ?.id ??
                                      '');
                            },
                            child: Text(
                              'Try Again',
                              style: Theme.of(context).textTheme.titleMedium,
                            ))
                      ],
                    );
                  } else if (state is GetRoomSuccessState) {
                    return StreamBuilder<QuerySnapshot<RoomEntity>>(
                        stream: state.querySnapShot,
                        builder: (context,snapshot){
                          if(snapshot.connectionState==ConnectionState.waiting){
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppTheme.primaryColor,
                              ),
                            );
                          }else if(snapshot.hasError){
                            return Column(
                              children: [
                                Text(
                                  'Something went wrong',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: AppTheme.blackColor),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      viewModel.getRoomFromFireStore(
                                          AuthViewModel.getProvider(context)
                                              .currentUser
                                              ?.id ??
                                              '');
                                    },
                                    child: Text(
                                      'Try Again',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ))
                              ],
                            );
                          }
                          List<RoomEntity> roomList = snapshot.data!.docs.map((doc) => doc.data()).toList();
                          if(roomList.isEmpty){
                            return Center(child: Text('There are no Tasks Currently'),);
                          }
                          return  Column(
                            children: [
                              Expanded(
                                child: GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 15.h,
                                        crossAxisSpacing: 15.w
                                    ),
                                    itemBuilder: (context,index){
                                      return InkWell(
                                        onTap: (){
                                          Navigator.of(context).pushNamed(ChatScreen.routeName,arguments: roomList[index]);
                                        },
                                          child: RoomItem(roomTitle: roomList[index].roomName??'', categoryId: roomList[index].categoryId??''));
                                    },
                                  itemCount: roomList.length,
                                ),
                              )
                            ],
                          );

                        });
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          )
        ]));
  }
}
