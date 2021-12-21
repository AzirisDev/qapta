import 'package:ad_drive/presentation/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ContractScreen extends StatelessWidget {
  const ContractScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title:"Контракт"),
      body: Column(
        children: const [
          Text("Contract"),
          Text("Contract"),
          Text("Contract"),
          Text("Contract"),
          Text("Contract"),
          Text("Contract"),
          Text("Contract"),
          Text("Contract"),
          Text("Contract"),
          Text("Contract"),
          Text("Contract"),
          Text("Contract"),
          Text("Contract"),
          Text("Contract"),
        ],
      ),
    );
  }
}
