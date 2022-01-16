import 'package:ad_drive/model/company.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/base/base_view_model.dart';
import 'package:image_picker/image_picker.dart';

class SubscribeViewModel extends BaseViewModel {
  SubscribeViewModel(ScreenState state) : super(state);

  Company? company;
  int? index;

  XFile? idFront;
  XFile? idBack;
  XFile? driverLicenceFront;
  XFile? driverLicenceBack;
}
