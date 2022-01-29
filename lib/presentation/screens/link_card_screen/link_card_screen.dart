import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/model/card.dart';
import 'package:ad_drive/presentation/components/credit_card/credit_card_form.dart';
import 'package:ad_drive/presentation/components/credit_card/credit_card_widget.dart';
import 'package:ad_drive/presentation/components/custom_app_bar.dart';
import 'package:ad_drive/presentation/components/custom_button.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';

class LinkCardScreen extends StatefulWidget {
  const LinkCardScreen({Key? key}) : super(key: key);

  @override
  _LinkCardScreenState createState() => _LinkCardScreenState();
}

class _LinkCardScreenState extends State<LinkCardScreen> {
  String cardNumber = '';
  String cardHolderName = '';
  OutlineInputBorder? border;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onCreditCardModelChange(CustomCreditCardModel model) {
    setState(() {
      cardNumber = model.cardNumber;
      cardHolderName = model.cardHolderName;
    });
  }

  @override
  Widget build(BuildContext context) {
    border = const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.PRIMARY_BLUE,
        width: 1.0,
      ),
    );

    return GeneralScaffold(
      appBar: customAppBar(title: "Карта"),
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              CustomCreditCardWidget(
                cardBgColor: AppColors.PRIMARY_BLUE,
                cardNumber: cardNumber,
                expiryDate: '',
                cardHolderName: cardHolderName,
                cvvCode: '',
                showBackView: false,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CustomCreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        themeColor: Colors.blue,
                        textColor: AppColors.MONO_BLACK,
                        cardNumberDecoration: InputDecoration(
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        cardHolderDecoration: InputDecoration(
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomButton(
                            title: "Validate",
                            onClick: () {
                              //TODO: validate card numberand card holder name
                              if (formKey.currentState!.validate()) {
                                Navigator.pop(context,
                                    CardModel(cardNumber: cardNumber, cardHolder: cardHolderName));
                              }
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.MONO_WHITE,
    );
  }
}
