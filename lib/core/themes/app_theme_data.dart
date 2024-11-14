import 'package:flutter/material.dart';
import '../constants/colors/app_colors.dart';

class AppThemeData {
  static ThemeData get defaultheme {
    return ThemeData(
      fontFamily: "Inter",
      brightness: Brightness.dark, // Sử dụng chủ đề tối làm cơ sở
      primaryColor: AppColors.primaryColor, // Màu chính cho ứng dụng
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch:
            Colors.grey, // Điều này sẽ tạo ra màu chính và các sắc thái của nó
        brightness: Brightness.dark, // Độ sáng chung của bảng màu này
      ).copyWith(
        secondary:
            AppColors.buttonColor, // Được sử dụng cho nút bấm và công tắc, v.v.
      ),
      scaffoldBackgroundColor: AppColors.primaryColor, // Màu nền cho Scaffold
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundColor, // Màu nền cho AppBar
        titleTextStyle: TextStyle(
            fontSize: 18,
            color: AppColors.textPrimaryColor,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700),
        iconTheme: IconThemeData(color: AppColors.iconPrimaryColor),
        toolbarHeight: 68,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimaryColor,
        ),
        bodyLarge: TextStyle(
            color: AppColors.textPrimaryColor,
            fontSize: 18), // Kiểu văn bản mặc định cho văn bản cơ thể
        bodyMedium: TextStyle(
            color: AppColors.textPrimaryColor,
            fontSize: 16), // Văn bản nhỏ hơn một chút
        headlineMedium: TextStyle(
            color: AppColors.textPrimaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold), // Cho tiêu đề
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xffEEEEEE),
        hintStyle: TextStyle(color: AppColors.textSecondarColor),
        suffixIconColor: AppColors.iconPrimaryColor,
        prefixIconColor: AppColors.iconPrimaryColor,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),

      tabBarTheme: TabBarTheme(
        indicatorColor: const Color(0xffFF8036),
        unselectedLabelStyle: const TextStyle(
          color: Color(0xFF637394),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        labelStyle: TextStyle(
            color: const Color(0xffFF8036),
            fontSize: 16,
            fontWeight: FontWeight.w700,
            shadows: [
              Shadow(
                blurRadius: 16,
                color: const Color(0xffFF8036).withOpacity(.5),
              )
            ]),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all(AppColors.buttonColor), // Màu nền
          foregroundColor:
              WidgetStateProperty.all(Colors.white), // Màu chữ và icon
          elevation: WidgetStateProperty.all(5), // Độ cao của bóng
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              // Hình dạng của nút
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          textStyle: WidgetStateProperty.all(const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          )),
          shadowColor:
              WidgetStateProperty.all(AppColors.buttonColor.withOpacity(.5)),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(
                horizontal: 30, vertical: 16), // Khoảng cách bên trong
          ),
        ),
      ),

      switchTheme: SwitchThemeData(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
      splashColor:
          const Color(0xff637394).withOpacity(.05), // Màu splash effect
      highlightColor: Colors.transparent,
    );
  }
}
