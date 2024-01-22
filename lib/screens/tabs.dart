import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pt/screens/accounts.dart';
import 'package:pt/screens/analytics.dart';
import 'package:pt/screens/home_tab.dart';
import 'package:pt/screens/profile.dart';
import 'package:pt/screens/transactions.dart';

class TabsScreen extends ConsumerStatefulWidget {
  TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = HomeTab();
    var activePageTitle = 'Home';

    if (_selectedPageIndex == 1) {
      activePage = Accounts();
      activePageTitle = 'Accounts';
    }

    if (_selectedPageIndex == 2) {
      activePage = Expenses();
      activePageTitle = 'Expenses';
    }

    if (_selectedPageIndex == 3) {
      activePage = analytics();
      activePageTitle = 'Analytics';
    }

    if (_selectedPageIndex == 4) {
      activePage = profiletab();
      activePageTitle = 'profiletab';
    }

    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.background,
            icon: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.background,
            icon: Icon(
              Icons.credit_card,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            label: 'Accounts',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.background,
            icon: Icon(
              Icons.compare_arrows,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.background,
            icon: Icon(
              Icons.analytics_outlined,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.background,
            icon: Icon(
              Icons.account_circle_outlined,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            label: 'profiletab',
          ),
        ],
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
      ),
    );
  }
}
