import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/theme/text_theme.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({Key? key, required this.passwordController})
      : super(key: key);
  final TextEditingController passwordController;

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.text,
        controller: widget.passwordController,
        style: AppTextStyles.regularText16
            .copyWith(color: Theme.of(context).primaryIconTheme.color),
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
              icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).hintColor),
            ),
            isDense: true,

            // border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 3,
                  color: AppColors.purple,
                )),
            hintText: I10n.of(context).password,
            //  hintStyle: ,
            //label: Text('Pinga'),
            // errorText: 'Carepito',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    style: BorderStyle.solid)),
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            filled: true));
  }
}
