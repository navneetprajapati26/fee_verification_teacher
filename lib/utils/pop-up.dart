import 'package:flutter/material.dart';

showPopUp({required BuildContext context, List<Widget>? children, double? width = 800 }){

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
          width: width,
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