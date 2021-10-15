import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vendas/app/controllers/view_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final viewController = Provider.of<ViewController>(context);
    return Stack(
      children: [
        Scaffold(
          body: viewController.getCurrentView(),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.blueAccent,
            selectedIconTheme: const IconThemeData(
              color: Colors.white,
              size: 21,
            ),
            unselectedIconTheme: const IconThemeData(
              color: Colors.white30,
              size: 17,
            ),
            onTap: (index) {
              viewController.setCurrentViewIndex(index);
            },
            currentIndex: viewController.currentViewIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.tag),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.shoppingBag,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.users,
                ),
                label: '',
              ),
            ],
          ),
        ),
        Visibility(
          visible: viewController.isLoading,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black38,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}
