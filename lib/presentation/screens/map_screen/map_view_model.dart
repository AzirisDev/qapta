import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/base/base_view_model.dart';
import 'package:image_picker/image_picker.dart';

class MapViewModel extends BaseViewModel {
  MapViewModel(ScreenState state) : super(state);

  XFile? photo;
}
