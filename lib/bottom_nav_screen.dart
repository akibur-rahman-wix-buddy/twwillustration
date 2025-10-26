// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'assets_helper/app_colors.dart';
import 'assets_helper/app_icons.dart';

class MainBottomNavScreen extends StatefulWidget {
  final int initialIndex;

  const MainBottomNavScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColor.primaryColor,
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: onItemTapped,
            selectedItemColor: AppColor.buttonColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: _selectedIndex == 0
                    ? SvgPicture.asset(
                  AppIcons.homeIcon,
                  width: 28.w,
                  height: 28.h,
                )
                    : SvgPicture.asset(
                  AppIcons.homeIcon1,
                  width: 28.w,
                  height: 28.h,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 1
                    ? SvgPicture.asset(
                  AppIcons.chatIcon1,
                  width: 28.w,
                  height: 28.h,
                )
                    : SvgPicture.asset(
                  AppIcons.chatIcon,
                  width: 28.w,
                  height: 28.h,
                ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 2
                    ? SvgPicture.asset(
                  AppIcons.storeIcon1,
                  width: 28.w,
                  height: 28.h,
                )
                    : SvgPicture.asset(
                  AppIcons.storeIcon,
                  width: 28.w,
                  height: 28.h,
                ),
                label: 'Store',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 3
                    ? SvgPicture.asset(
                  AppIcons.webinarIcon1,
                  width: 28.w,
                  height: 28.h,
                )
                    : SvgPicture.asset(
                  AppIcons.webinarIcon,
                  width: 28.w,
                  height: 28.h,
                ),
                label: 'Webinar',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 4
                    ? SvgPicture.asset(
                  AppIcons.profileIcon1,
                  width: 28.w,
                  height: 28.h,
                )
                    : SvgPicture.asset(
                  AppIcons.profileIcon,
                  width: 28.w,
                  height: 28.h,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}