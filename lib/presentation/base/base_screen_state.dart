enum ScreenState { Loading, Updating, Error, Done, Reading, Uploading, None }

extension ScreenStateExt on ScreenState {
  bool get isLoading => this == ScreenState.Loading;

  bool get isUpdating => this == ScreenState.Updating;

  bool get isDone => this == ScreenState.Done;

  bool get isError => this == ScreenState.Error;

  bool get isReading => this == ScreenState.Reading;

  bool get isUploading => this == ScreenState.Uploading;

  bool get isNone => this == ScreenState.None;
}
