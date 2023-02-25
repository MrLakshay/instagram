import 'package:flutter/material.dart';
import 'package:instagram/utils/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget phoneScreenLayout;
  const ResponsiveLayout({Key? key, required this.webScreenLayout, required this.phoneScreenLayout,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constraints){
          if(constraints.maxWidth>webScreenSize){
            //web screeen
            return webScreenLayout;
          }
          else{
            return phoneScreenLayout;
            //mobile screen layout
          }
    });
  }
}
