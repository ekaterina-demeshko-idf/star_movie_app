import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
import 'package:presentation/mappers/login_error_view_mapper.dart';

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
  final dateErrorViewMapper = ErrorViewMapper();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocData>(
        stream: bloc.dataStream,
        builder: (context, snapshot) {
          final l10n = AppLocalizations.of(context)!;
          return Scaffold(
            backgroundColor: PrimaryColors.primaryBackgroundColor,
            appBar: AppBar(
              backgroundColor: PrimaryColors.primaryBackgroundColor,
              title: Text(l10n.payment),
            ),
            body: Padding(
              padding: const EdgeInsets.all(Dimens.size18),
              child: SingleChildScrollView(
                child: Form(
                  key: bloc.formKey,
                  child: Column(
                    children: [
                      Text(
                        l10n.phoneNumber,
                        style: AppTextStyles.headerStyle(Dimens.size16),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: Dimens.size10),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CustomPhoneFormatter(),
                        ],
                        style: AppTextStyles.headerStyle(Dimens.size16),
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
                            Icons.phone,
                            color: PrimaryColors.whiteWithOpacity45,
                          ),
                          filled: true,
                          fillColor: PrimaryColors.backgroundTextField,
                        ),
                      ),
                      const SizedBox(height: Dimens.size20),
                      Container(
                        decoration: BoxDecoration(
                          color: PrimaryColors.cardColor,
                          border: Border.all(
                            width: Dimens.size4,
                            color: PrimaryColors.cardColor,
                          ),
                          borderRadius: BorderRadius.circular(Dimens.size12),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: Dimens.size10),
                            Text(
                              l10n.cardNumber,
                              style: AppTextStyles.headerStyle(Dimens.size16),
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
                              style: AppTextStyles.headerStyle(Dimens.size16),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(Dimens.size4),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                  Icons.credit_card,
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
                            const SizedBox(height: Dimens.size26),
                            SizedBox(
                              height: Dimens.size120,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          l10n.date,
                                          style: AppTextStyles.headerStyle(
                                            Dimens.size16,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(height: Dimens.size10),
                                        TextFormField(
                                          validator: (_) {
                                            return dateErrorViewMapper
                                                .mapDateErrorToMessage(
                                              context,
                                              bloc.validationModel?.date,
                                            );
                                          },
                                          onChanged: (_) {
                                            bloc.onChangedTextForm();
                                          },
                                          controller: bloc.dateController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(4),
                                            CustomDateFormatter(),
                                          ],
                                          style: AppTextStyles.headerStyle(
                                            Dimens.size16,
                                          ),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                Dimens.size4,
                                              ),
                                              borderSide: BorderSide.none,
                                            ),
                                            prefixIcon: const Icon(
                                              Icons.date_range,
                                              color: PrimaryColors
                                                  .whiteWithOpacity45,
                                            ),
                                            hintText: 'MM/YY',
                                            hintStyle: const TextStyle(
                                              color: PrimaryColors
                                                  .whiteWithOpacity45,
                                            ),
                                            filled: true,
                                            fillColor: PrimaryColors
                                                .backgroundTextField,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: Dimens.size10),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'CVV',
                                          style: AppTextStyles.headerStyle(
                                            Dimens.size16,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(height: Dimens.size10),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(3),
                                          ],
                                          obscureText: true,
                                          style: AppTextStyles.headerStyle(
                                            Dimens.size16,
                                          ),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                Dimens.size4,
                                              ),
                                              borderSide: BorderSide.none,
                                            ),
                                            prefixIcon: const Icon(
                                              Icons.lock_outline,
                                              color: PrimaryColors
                                                  .whiteWithOpacity45,
                                            ),
                                            filled: true,
                                            fillColor: PrimaryColors
                                                .backgroundTextField,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Dimens.size20),
                      ElevatedButton(
                        onPressed: bloc.onValidate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimaryColors.primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.size120,
                            vertical: Dimens.size18,
                          ),
                        ),
                        child: Text(
                         l10n.save,
                          style: AppTextStyles.headerStyle(Dimens.size16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
