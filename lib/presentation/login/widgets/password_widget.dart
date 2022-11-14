import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

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
        style: TextStyle(
            color: Theme.of(context).primaryIconTheme.color, fontSize: 16),
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
            //  contentPadding: const EdgeInsets.all(15),
            // icon: Icons.lock,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
              icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.purple),
            ),
            isDense: true,

            // border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 3,
                  color: AppColors.purple,
                )),
            hintText: "Contraseña",
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
