import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/base/base_view_model.dart';

class ProfileViewModel extends BaseViewModel {
  ProfileViewModel(ScreenState state) : super(state);

  late final UserData userData;
}
