import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation/base/bloc_data.dart';
import 'package:presentation/base/bloc_screen.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/screen/payment/payment_bloc.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimens.dart';
import 'package:presentation/utils/formatters.dart';
import 'package:presentation/utils/text_styles.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  static const _routeName = '/PaymentScreen';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const PaymentScreen(),
        hideNavBar: false,
      );

  @override
  State createState() => _PaymentScreenState();
}

class _PaymentScreenState extends BlocScreenState<PaymentScreen, PaymentBloc> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocData>(
        stream: bloc.dataStream,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: PrimaryColors.primaryBackgroundColor,
            appBar: AppBar(
              backgroundColor: PrimaryColors.primaryBackgroundColor,
              title: const Text('Payment'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: bloc.formKey,
                child: Column(
                  children: [
                    Text(
                      'Phone',
                      style: AppTextStyles.descriptionStyle(Dimens.size16),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: Dimens.size10),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CustomPhoneFormatter(),
                      ],
                      style: AppTextStyles.descriptionStyle(Dimens.size16),
                      decoration: InputDecoration(
                        hintText: '+375 (xx) xxx-xx-xx',
                        hintStyle: const TextStyle(
                          color: PrimaryColors.whiteWithOpacity45,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimens.size4),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: PrimaryColors.whiteWithOpacity45,
                        ),
                        filled: true,
                        fillColor: PrimaryColors.backgroundTextField,
                      ),
                    ),
                    const SizedBox(height: Dimens.size10),
                    Text(
                      'Card Number',
                      style: AppTextStyles.descriptionStyle(Dimens.size16),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: Dimens.size10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        CustomCardFormatter(),
                        LengthLimitingTextInputFormatter(19),
                      ],
                      style: AppTextStyles.descriptionStyle(Dimens.size16),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimens.size4),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: PrimaryColors.whiteWithOpacity45,
                        ),
                        hintText: 'xxxx xxxx xxxx xxxx',
                        hintStyle: const TextStyle(
                          color: PrimaryColors.whiteWithOpacity45,
                        ),
                        filled: true,
                        fillColor: PrimaryColors.backgroundTextField,
                      ),
                    ),
                    const SizedBox(height: 26),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Date',
                                style: AppTextStyles.descriptionStyle(
                                    Dimens.size16),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return bloc.validateDate(value);
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(4),
                                  CustomDateFormatter(),
                                ],
                                style: AppTextStyles.descriptionStyle(
                                  Dimens.size16,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(Dimens.size4),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.person_outline,
                                    color: PrimaryColors.whiteWithOpacity45,
                                  ),
                                  hintText: 'MM/YY',
                                  hintStyle: const TextStyle(
                                    color: PrimaryColors.whiteWithOpacity45,
                                  ),
                                  filled: true,
                                  fillColor: PrimaryColors.backgroundTextField,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'CVV',
                                style: AppTextStyles.descriptionStyle(
                                  Dimens.size16,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                obscureText: true,
                                style: AppTextStyles.descriptionStyle(
                                  Dimens.size16,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(Dimens.size4),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.person_outline,
                                    color: PrimaryColors.whiteWithOpacity45,
                                  ),
                                  filled: true,
                                  fillColor: PrimaryColors.backgroundTextField,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
