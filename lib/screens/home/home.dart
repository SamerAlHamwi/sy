

import 'package:flutter/material.dart';
import 'package:sy/screens/processes/process_page.dart';
import 'package:sy/screens/work/work1_screen.dart';
import 'package:sy/screens/work/work2_screen.dart';
import 'package:sy/screens/work/work3_screen.dart';
import 'package:sy/screens/work/work4_screen.dart';


class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key,this.isWithUpdate = false});

  final bool isWithUpdate;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            title: null,
            bottom: const TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(
                    icon: Icon(Icons.accessibility_new_outlined,color: Colors.black,),
                    // text: "Settings",
                ),
                Tab(
                    icon: Icon(Icons.person,color: Colors.black,),
                    // text: "1"
                ),
                Tab(
                    icon: Icon(Icons.person,color: Colors.red,),
                    // text: "2"
                ),
                Tab(
                    icon: Icon(Icons.person,color: Colors.black,),
                    // text: "3"
                ),
                Tab(
                    icon: Icon(Icons.person,color: Colors.red,),
                    // text: "نقار"
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ProcessScreen(),
            WorkPage1(),
            WorkPage2(),
            WorkPage3(),
            WorkPage4(),
          ],
        ),
      ),
    );
  }
}


