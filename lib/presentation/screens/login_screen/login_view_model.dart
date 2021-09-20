import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/base/base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel(ScreenState state) : super(state);

  bool sendingCode = false;
}
