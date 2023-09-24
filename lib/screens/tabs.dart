import 'package:calculadora_imc/screens/historic.dart';
import 'package:calculadora_imc/screens/start.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int pageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var pageTitle = 'Calculador de IMC';

    Widget activePage = StartScreen();

    if (pageIndex == 1) {
      activePage = HistoricScreen();
      pageTitle = 'Historico';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).colorScheme.primary,
          currentIndex: pageIndex,
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.access_time), label: 'Histórico'),
          ]),
    );
  }
}
