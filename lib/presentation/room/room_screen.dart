import 'package:chat_app/domain/di.dart';
import 'package:chat_app/domain/entity/roomEntity.dart';
import 'package:chat_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:chat_app/presentation/room/cubit/room_states.dart';
import 'package:chat_app/presentation/room/cubit/room_view_model.dart';
import 'package:chat_app/presentation/room/widget/room_text_form_field.dart';
import 'package:chat_app/domain/entity/category.dart';
import 'package:chat_app/presentation/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_assets.dart';
import '../utils/app_theme.dart';

class RoomScreen extends StatefulWidget {
  static const String routeName = 'room screen';

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  var viewModel = RoomViewModel(addRoomUseCase: injectAddRoomUseCase());

  List<Category> categoryList = Category.getCategory();

  late Category selectedCategory ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCategory = categoryList[0];
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<RoomViewModel, RoomStates>(
      bloc: viewModel,
  listener: (context, state) {
    // TODO: implement listener
    if(state is AddRoomLoadingState){
      DialogUtils.showLoading(context);
    }else if(state is AddRoomErrorState){
      DialogUtils.hideLoading(context);
      DialogUtils.showMessage(context: context, title: 'Error', message: state.errorMessage,posActionName: 'ok');
    }else if(state is AddRoomSuccessState){
      DialogUtils.hideLoading(context);
      DialogUtils.showMessage(context: context, title: 'Success', message: 'Create Room Successfully',posActionName: 'ok');
    }
  },
  child: Container(
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium,
                  ),
                ),
                body: Container(
                  height: 555.h,
                  width: 334.w,
                  margin: EdgeInsets.all(20.h),
                  padding: EdgeInsets.all(25.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppTheme.whiteColor
                  ),
                  child: Form(
                    key: viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Create New Room',style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.blackColor
                        ),textAlign: TextAlign.center,),
                        SizedBox(height: 24.h,),
                        Image.asset(AppAssets.roomImage,width:140.w ,height:80.h ,fit: BoxFit.fill,),
                        SizedBox(height: 24.h,),
                        RoomTextField(
                          hintText: 'enter room name',
                          controller: viewModel.roomName,
                          validator: (name){
                          if(name==null||name.isEmpty){
                            return 'please enter room name';
                          }
                          return null ;
                        },),
                        SizedBox(height: 12.h,),
                        DropdownButton<Category>(
                          value: selectedCategory,
                            items: categoryList.map((category){
                              return DropdownMenuItem<Category>(
                                value: category,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                     Text(category.title,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                       fontSize: 18.sp,
                                       color: AppTheme.blackColor
                                     ),) ,
                                      Image.asset(category.image,fit: BoxFit.fill,height: 50.h,width: 50.w,)
                                    ],
                                  ));
                            }).toList(),
                            onChanged: (newCategory){
                            if(newCategory==null) return ;
                            selectedCategory=newCategory;
                            setState(() {

                            });
                            }),
                        SizedBox(height: 12.h,),
                        RoomTextField(
                          hintText: 'enter room description',
                          controller: viewModel.roomDesc,
                          validator: (desc){
                          if(desc==null||desc.isEmpty){
                            return 'please enter room description';
                          }
                          return null ;
                        },maxLines: 3,),
                        SizedBox(height: 24.h,),
                        ElevatedButton(onPressed: (){
                          //todo: create room
                          if(viewModel.formKey.currentState!.validate()){
                            var room = RoomEntity(categoryId: selectedCategory.id, roomName: viewModel.roomName.text, roomDescription: viewModel.roomDesc.text);
                            viewModel.addRoomToFireStore(room, AuthViewModel.getProvider(context).currentUser!.id??'');
                          }
                        }, child: Text('Create',style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18.sp),))
                      ],
                    ),
                  ),
                ),
              )
            ])),
);
  }
}
