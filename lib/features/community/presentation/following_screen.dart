// ignore_for_file: unused_element

import 'package:flutter/material.dart';

/// demo content pages (replace with your real widgets)
class FollowingTabScreen extends StatefulWidget {

  final int userId;
  // final String title;
  const FollowingTabScreen({
    super.key, required this.userId,
  });

  @override
  State<FollowingTabScreen> createState() => _FollowingTabScreenState();
}

class _FollowingTabScreenState extends State<FollowingTabScreen> {
  
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Center(
        child: Text(
          'Following person post'
        ),
      ),
    );
  }
}
