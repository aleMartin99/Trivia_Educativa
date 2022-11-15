import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'welcome_message_state.dart';

class WelcomeMessageCubit extends Cubit<WelcomeMessageState> {
  WelcomeMessageCubit() : super(WelcomeMessageInitial());
}
