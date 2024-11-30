import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/text_styles.dart';

class CustomInputTextField extends StatefulWidget {
  const CustomInputTextField({
    Key? key,
    this.icon,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    this.isPassword = false,
    this.suffixIcon,
    this.validationFunction,
    this.onChange,
  }) : super(key: key);

  final IconData? icon;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final Widget? suffixIcon;
  final String? Function(String?)? validationFunction;
  final Function(String)? onChange;

  @override
  State<CustomInputTextField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChange,
      obscureText: widget.isPassword ? !_isPasswordVisible : false,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      style: TextStyles.font17BlackPurpleBold.copyWith(
          color: Theme.of(context).primaryColor,
      ),
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        prefixIcon: widget.icon != null ? Icon(
          widget.icon,
          color: Theme.of(context).secondaryHeaderColor/* : Theme.of(context).hintColor*/,
        ) : null,
        labelText: widget.hintText,
        labelStyle: TextStyles.font11LightGreyBold.copyWith(
            color: Theme.of(context).hintColor,
        ),
        floatingLabelStyle: TextStyles.font15DarkGreySemiBold.copyWith(
          color: Theme.of(context).secondaryHeaderColor,
        ),
        filled: false,
        // fillColor: Theme.of(context).hoverColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Theme.of(context).primaryColorLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Theme.of(context).primaryColorLight),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Theme.of(context).primaryColorLight),
        ),
        contentPadding: EdgeInsets.only(
          top: 15.h,
          left: 10.w,
          right: 10.w,
          bottom: 20.h,
        ),
        errorStyle: TextStyles.font12RedBold,
        suffixIcon: widget.suffixIcon ??
            (widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          _isPasswordVisible = !_isPasswordVisible;
                        },
                      );
                    },
                    child: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: /*_isFocused*/
                          Theme.of(context).hintColor,
                          // : Theme.of(context).hintColor,
                    ),
                  )
                : null),
      ),
      validator: widget.validationFunction,
    );
  }
}