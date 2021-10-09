import 'package:ad_drive/presentation/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class LinkCardScreen extends StatefulWidget {
  const LinkCardScreen({Key? key}) : super(key: key);

  @override
  _LinkCardScreenState createState() => _LinkCardScreenState();
}

class _LinkCardScreenState extends State<LinkCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Link card"),
      body: Center(
        child: Text("Link Card"),
      ),
    );
  }
}
