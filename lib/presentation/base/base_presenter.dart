// import 'package:chipper/presentation/di/user_scope.dart';
import 'package:ad_drive/presentation/di/user_scope.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'base_screen_state.dart';
import 'base_view_model.dart';

abstract class BasePresenter<M extends BaseViewModel> {
  M model;
  final BehaviorSubject<M> _subject = BehaviorSubject<M>();
  late BuildContext context;
  Stream<M> get stream => _subject.stream;
  late UserScopeData userScope;

  BasePresenter(this.model);

  void initWithContext(BuildContext context) {
    bool firstInit = false;
    try {
      // ignore: unnecessary_statements
      this.context.hashCode != 0;
    } catch (e) {
      firstInit = true;
    }
    this.context = context;
    userScope = UserScopeWidget.of(context);
    if (firstInit) onInitWithContext();
  }

  void onInitWithContext() {}

  void dispose() {
    _subject.close();
  }

  void updateView() {
    if (!_subject.isClosed) _subject.sink.add(model);
  }

  void startLoading() {
    model.state = ScreenState.loading;
    updateView();
  }

  void endLoading() {
    model.state = ScreenState.done;
    updateView();
  }

  void startReading() {
    model.state = ScreenState.reading;
    updateView();
  }

  void endLoadingWithError() {
    model.state = ScreenState.error;
    updateView();
  }
}
