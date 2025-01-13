import 'package:flutter/material.dart';
import 'package:fuel_alert/widget/buttons/buttons.dart';

class PermissionDialogSheet {
  show(context, {title, subtitle, action, buttonName, denyAction}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).cardColor,
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            content: Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style:  TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 22,
                          color:
                              Theme.of(context).textTheme.headlineSmall?.color),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "PoppinsMeds",
                          fontSize: 14.28,
                          color: Theme.of(context).textTheme.titleSmall?.color),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Buttons()
                              .borderButtons(context, title: buttonName, action: denyAction),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Buttons().defaultButtons(
                              isLoading: false,
                              title: "Next",
                              action: action),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}
