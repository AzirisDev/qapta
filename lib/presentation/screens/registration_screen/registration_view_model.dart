import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/base/base_view_model.dart';

class RegistrationViewModel extends BaseViewModel {
  RegistrationViewModel(ScreenState state) : super(state);

  bool entering = false;

  UserData? userModel;
  String? avatarUrl;
}
