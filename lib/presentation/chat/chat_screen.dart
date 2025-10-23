import 'package:chat_app/domain/di.dart';
import 'package:chat_app/domain/entity/message.dart';
import 'package:chat_app/domain/entity/roomEntity.dart';
import 'package:chat_app/presentation/chat/cubit/chat_states.dart';
import 'package:chat_app/presentation/chat/cubit/chat_view_model.dart';
import 'package:chat_app/presentation/chat/widget/message_item_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../auth/cubit/auth_cubit.dart';
import '../utils/app_assets.dart';
import '../utils/app_theme.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat Screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  late ChatViewModel viewModel ;
  late RoomEntity args ;
  bool _isInitialized = false;

  @override
  void initState() {
     super.initState();
     viewModel = ChatViewModel(
       sendMessageUseCase: injectSendMessageUseCase(),
       receiveMessageUseCase: injectReceiveMessageUseCase(),
     );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      args = ModalRoute.of(context)!.settings.arguments as RoomEntity;
      viewModel.receiveMessages(args.id ?? '');
      _isInitialized = true;
    }
  }


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
                args.roomName ?? '',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            body: BlocListener<ChatViewModel, ChatStates>(
              bloc: viewModel,
              listener: (context, state) {
                if (state is ChatSendErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        state.errorMessage,
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                      ),
                    ),
                  );
                }
                if (state is ChatSendSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.blue,
                      content: Text(
                        'Message sent successfully',
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                      ),
                    ),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.all(10.w),
                margin: EdgeInsets.all(22.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Today',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),

                    /// ✅ Messages Stream
                    Expanded(
                      child: BlocBuilder<ChatViewModel, ChatStates>(
                        bloc: viewModel,
                        builder: (context, state) {
                          if (state is ChatReceiveErrorState) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.errorMessage,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    viewModel.receiveMessages(args.id ?? '');
                                  },
                                  child: Text('Try Again'),
                                ),
                              ],
                            );
                          } else if (state is ChatReceiveLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            );
                          } else if (state is ChatReceiveSuccessState) {
                            return StreamBuilder<QuerySnapshot<MessageEntity>>(
                              stream: state.querySnapShot,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: AppTheme.primaryColor,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Something went wrong',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                            color: AppTheme.blackColor),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 20.h),
                                      ElevatedButton(
                                        onPressed: () {
                                          viewModel.receiveMessages(
                                              args.id ?? '');
                                        },
                                        child: Text(
                                          'Try Again',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                List<MessageEntity> messageList = snapshot
                                    .data!.docs
                                    .map((doc) => doc.data())
                                    .toList();

                                if (messageList.isEmpty) {
                                  return Center(
                                    child:
                                    Text('There are no messages currently'),
                                  );
                                }

                                return ListView.separated(
                                  itemBuilder: (context, index) {
                                    return MessageItemWidget(
                                      messageEntity: messageList[index],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 10.r),
                                  itemCount: messageList.length,
                                );
                              },
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),

                    /// ✅ Message Input
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: viewModel.messageController,
                            style: Theme.of(context).textTheme.titleSmall,
                            decoration: InputDecoration(
                              hintText: 'Type a message',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w400),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppTheme.blackColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        ElevatedButton(
                          onPressed: () {
                            final currentUser = AuthViewModel.getProvider(context).currentUser;
                            if (currentUser == null) return;

                            final messageEntity = MessageEntity(
                              roomId: args.id ?? '',
                              userId: currentUser.id ?? '',
                              content: viewModel.messageController.text,
                              userName: currentUser.name ?? '',
                              dateTime: DateTime.now().millisecondsSinceEpoch
                            );

                            viewModel.sendMessage(messageEntity);
                            viewModel.messageController.clear();
                          },
                          child: Row(
                            children: [
                              Text(
                                'Send',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontSize: 18.sp),
                              ),
                              SizedBox(width: 2.sp),
                              Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 25.sp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
