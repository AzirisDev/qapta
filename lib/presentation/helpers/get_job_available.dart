class JobAvailability{
  bool getJobAvailable(){
    return DateTime.now().hour < 20 && DateTime.now().hour > 9;
  }
}