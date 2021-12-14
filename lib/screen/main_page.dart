import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_market/pages/category_page.dart';
import 'package:open_market/pages/products_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController _controller;
  int _page = 0;

  @override
  void initState() {
    _controller = PageController(
      initialPage: _page,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Open marcket"),
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: _onPageChanged,
        children: [
          const ProductsPage(),
          const CategoryPage(),
          Container(
            color: Colors.orange,
          ),
          Container(
            color: Colors.green,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff21ce99),
        onPressed: () {},
        child: const Icon(CupertinoIcons.money_dollar),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.app_badge), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.tag), label: "Categorie"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bell), label: "Notification"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), label: "Account"),
        ],
        //showUnselectedLabels: true,
        onTap: _onNavigationTapped,
        currentIndex: _page,
      ),
    );
  }

  _onNavigationTapped(int page) {
    _controller.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  _onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
}
