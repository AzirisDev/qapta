import 'dart:io';

import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/base/base_view_model.dart';

class TakePhotoViewModel extends BaseViewModel {
  TakePhotoViewModel(ScreenState state) : super(state);

  late File Function() onClick;
}
