import 'package:flutter/material.dart';

showPopUp({required BuildContext context, List<Widget>? children}){

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        surfaceTintColor: Colors.white,
        insetPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Container(
          width: 800,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children?? [],
          ),
        ),
      );
    },
  );


}