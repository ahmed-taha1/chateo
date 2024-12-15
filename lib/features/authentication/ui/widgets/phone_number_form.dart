import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_input_text_field.dart';
import '../../../../core/widgets/spacing.dart';

class PhoneNumberForm extends StatelessWidget {
  final String header;
  final Function(String) onProceed;

  const PhoneNumberForm(
      {super.key, required this.header, required this.onProceed});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 80.h,
            bottom: 20.h,
            left: 40.w,
            right: 40.w,
          ),
          child: Column(
            children: [
              verticalSpace(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      header,
                      style: TextStyles.font15BlackPurpleSemiBold.copyWith(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 30.sp,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              verticalSpace(40),
              CustomInputTextField(
                hintText: "Phone Number",
                controller: phoneController,
                keyboardType: TextInputType.phone,
                icon: Icons.phone,
              ),
              verticalSpace(40),
              CustomButton(
                text: "Proceed",
                onPressed: (){
                  onProceed(phoneController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
