import 'package:ad_drive/model/company.dart';
import 'package:ad_drive/presentation/base/base_screen_state.dart';
import 'package:ad_drive/presentation/base/base_view_model.dart';

class CompaniesViewModel extends BaseViewModel {
  CompaniesViewModel(ScreenState state) : super(state);

  List<Company>? companies;
}
