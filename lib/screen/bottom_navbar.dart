import 'package:flutter/material.dart';
import 'package:kas_app/screen/dashboard_screen.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({ Key? key }) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {

  int _counter = 0;
  int _botton = 0;

  final List<Widget> _item = [
    dashboard_screen(),
    
  ];

  void _onItemTap (int index) {
    setState(() {
      _botton = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _item.elementAt(_botton),
      ),
      
       bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.feed),
              label: 'Menu 1',
            ),
            
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_rounded),
              label: 'Menu 2',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.open_in_browser_sharp),
              label: 'Menu 3',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'Menu 4',
            ),
          ],
          currentIndex: _botton,
          onTap: _onItemTap,
        ),
      
    );
  }
}