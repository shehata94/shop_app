import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors.dart';

void navigateAndFinish(context, screen) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen), (route) => false);
}

void navigateTo(context, screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

Widget defaultTextForm(
        {@required TextEditingController controller,
        @required TextInputType inputType,
        @required IconData prefix,
        bool isPassword = false,
        IconData suffix,
        @required String label,
        ValueChanged<String> onSubmit,
        Function validate,
        Function suffixPressed,
        Function onTap,
        Function onChange,
          String initValue

        }) =>
    TextFormField(
      initialValue: initValue,
      obscureText: isPassword,
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(
                  suffix,
                ),
                onPressed: suffixPressed,
              )
            : null,
        labelText: label,
      ),
      onFieldSubmitted: onSubmit,
      validator: validate,
      onTap: onTap,
      onChanged: onChange,
    );

Widget defaultButton(
        {double width = double.infinity, Color color = primaryColor, @required String label, Color textColor = Colors.white, Function onPressed}) =>
    Container(
      width: width,
      color: color,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(color: textColor),
        ),
      ),
    );

