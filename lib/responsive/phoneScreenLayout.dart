import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';

class PhoneScreenLayout extends StatefulWidget {
  const PhoneScreenLayout({Key? key}) : super(key: key);

  @override
  State<PhoneScreenLayout> createState() => _PhoneScreenLayoutState();
}

class _PhoneScreenLayoutState extends State<PhoneScreenLayout> {
  String username = "";
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    getUsername();
  }
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }
  @override
  Widget build(BuildContext context) {
    int _page = 0;
    void navigationTapped(int page) {
      pageController.jumpToPage(page);
    }
    void onPageChanged(int page) {
      setState(() {
        _page=page;
      });
    }
    return Scaffold(
      body: PageView(
        children: [
          Text('home'),
          Text('search'),
          Text('add post'),
          Text('love'),
          Text('account'),
        ],
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: (_page == 0) ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,
                color: (_page == 1 )? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,
                color: (_page == 2) ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,
                color: (_page == 3) ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(color: (_page == 4) ? primaryColor : secondaryColor,
                Icons.person),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
