import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCounterCubit extends Cubit<int> {
  NotificationCounterCubit() : super(0);

  void increment() => emit(state + 1);

  void reset() => emit(0);
}
