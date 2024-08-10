import 'package:flutter/material.dart';
import 'package:todo/app_colors.dart';
class ThemeDatamain{
  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundLightColor ,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          elevation: 0
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.groycolor,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent
          ,elevation: 0
      ),
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
              side: BorderSide(color: AppColors.whiteCoLor,width: 4))
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: AppColors.whiteCoLor,width: 4))
      )

  );
}
