import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

Widget loader(){
  return Center(
    child: CircularProgressIndicator(
      color: AppColors.primaryappcolor,
    ),
  );
}