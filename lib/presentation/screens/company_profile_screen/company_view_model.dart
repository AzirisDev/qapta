import 'package:ad_drive/model/company.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/base/base_view_model.dart';

class CompanyViewModel extends BaseViewModel {
  CompanyViewModel(ScreenState state) : super(state);

  late Company company;
}
