import 'package:ad_drive/model/user.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/base/base_view_model.dart';

class VerificationViewModel extends BaseViewModel {
  VerificationViewModel(ScreenState state) : super(state);

  String? verificationId;

  bool verifyCode = false;

  late UserData userModel;
}
