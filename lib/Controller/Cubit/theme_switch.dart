import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSwitch extends Cubit<bool> {
  ThemeSwitch() : super(false);

  void switchMode() {
    emit(!state);
    // print(state);
  }
}
