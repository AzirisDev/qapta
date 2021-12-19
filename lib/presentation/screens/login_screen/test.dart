import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/components/custom_textfield.dart';
import 'package:ad_drive/styles.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Аккаунт",
          style: appBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 300,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 20,
                                offset: Offset(0, 0), // changes position of shadow
                              ),
                            ]),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 130,
                              decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(Radius.circular(20))),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                child: Image.network(
                                  'https://s3-alpha-sig.figma.com/img/fd16/f7c0/f7413b2e46fd5b05c964dd658938cd24?Expires=1640563200&Signature=WkfHgDlCgFMifiz3mGrrQsyFQL8tHyG8F3gcghZXu9dcYDYdRds8HaBe~DqazvC8vR8oh9WhsmZvdwUOJMZv7W4v2VBtwgoV6Q-G--ratu2O8cFAd4u7PULs8Nos9iNL8vzG6JhX~5JS15tcGc8iPBlzVBUjwVg3aNsV8oJjS~yL0iuzS3abU~Ef7qnf8fniQGNbWtheuIeRr9V-H6mPxitOegYgRiwgQ2coeaokU1x8mtvoZYXQvvHD-ZdSMVEs7A4bkEHFY5N69dZf-QvutV-hBeNDoQQIMR5kerPjyPuJOqJKmWuJFVLCLh2O2NPd7JmEOZSn8Nj8q~KfB7u9-Q__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Tamina Temirkhan",
                                      style: TextStyle(
                                          color: AppColors.PRIMARY_BLUE,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Raleway'),
                                    ),
                                    Text(
                                      "tamina@gmail.com",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Raleway'),
                                    ),
                                    Divider(
                                      height: 10,
                                      color: AppColors.MONO_BLACK,
                                    ),
                                    Text(
                                      "8 708 305 43 53",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Raleway'),
                                    ),
                                    Divider(
                                      height: 10,
                                      color: AppColors.MONO_BLACK,
                                    ),
                                    Text(
                                      "Сейчас продвигает: \nApple.kz",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Raleway'),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              SettingTile(title: 'Карта', onClick: (){},),
              SettingTile(title: 'Договор с Qapta', onClick: (){},),
              SettingTile(title: 'Условия эксплуатации', onClick: (){},),
              SettingTile(title: 'Политика конфиденциальности', onClick: (){},),
              SettingTile(title: 'Выйти', onClick: (){}, isLogOut: true),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final String title;
  final void Function() onClick;
  final bool isLogOut;
  const SettingTile({
    Key? key, required this.title, required this.onClick, this.isLogOut = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ]),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w400,

                        ),
                      ),
                    ),
                    Icon(isLogOut ? Icons.exit_to_app_rounded : Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
