import 'package:chat_app/presentation/home/cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/log_out_use_case.dart';

class HomeScreenViewModel extends Cubit<HomeStates>{
  HomeScreenViewModel():super(HomeInitialState());

}