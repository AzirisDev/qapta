import 'package:ad_drive/presentation/base/base_presenter.dart';
import 'package:ad_drive/presentation/screens/company_profile_screen/company_view_model.dart';

class CompanyPresenter extends BasePresenter<CompanyViewModel> {
  CompanyPresenter(CompanyViewModel model) : super(model);

  int index = 2;

  bool isExpand = false;

  List<String> adverts = ['Лобовое', 'Бампер', 'Полностью'];

  void expandText(){
    isExpand = !isExpand;
    updateView();
  }

  void onTapInfoContainer(int currentIndex) {
    index = currentIndex;
    updateView();
  }
}
