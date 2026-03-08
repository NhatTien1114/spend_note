import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spend_note/screen/main_page/account_screen.dart';
import 'package:spend_note/screen/main_page/add_transaction_screen.dart';
import 'package:spend_note/screen/main_page/dashboard_screen.dart';
import 'package:spend_note/screen/main_page/other_screen.dart';
import 'package:spend_note/screen/main_page/report_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController pageController;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void pageChange(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 10.h),
        child: Container(
          height: 60.h,
          decoration: BoxDecoration(
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
                offset: Offset(0, 5)
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.lightBlue[700],
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              currentIndex: _currentIndex,
              onTap: (index) {
                pageController.jumpToPage(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.house, size: 14.sp),
                  label: "Tổng quan",
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.wallet, size: 14.sp),
                  label: "Tài khoản",
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.plus, size: 16.sp),
                  label: "Thêm",
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.chartPie, size: 14.sp),
                  label: "Báo cáo",
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.ellipsis, size: 14.sp),
                  label: "Khác",
                ),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: pageChange,
        children: const [
          DashboardScreen(),
          AccountScreen(),
          AddTransactionScreen(),
          ReportScreen(),
          OtherScreen(),
        ],
      ),
    );
  }
}