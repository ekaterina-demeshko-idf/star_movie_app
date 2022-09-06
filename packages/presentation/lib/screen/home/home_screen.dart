import 'package:flutter/material.dart';
import 'package:presentation/utils/colors.dart';
import '../../base/bloc_screen.dart';
import '../../navigation/base_arguments.dart';
import '../../navigation/base_page.dart';
import '../../utils/widgets/tabbar.dart';
import 'home_bloc.dart';

class HomeScreenArguments extends BaseArguments {
  HomeScreenArguments({
    Function(dynamic value)? result,
  }) : super(result: result);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const _routeName = '/HomeScreen';

  static BasePage page(HomeScreenArguments arguments) => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const HomeScreen(),
        arguments: arguments,
      );

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends BlocScreenState<HomeScreen, HomeBloc>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(PrimaryColors.primaryBackgroundColor),
          title: const Text(
            'Star Movie',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: '.SF Pro Text'),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 40,
              ),
              color: Colors.white,
            ),
          ]),
      body: SafeArea(
        child: Column(
          children: [
            TabBarContainer(tabController: tabController),
            Flexible(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: 10,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text("name"),
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 15),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 0.5,
              color: Colors.grey,
            ),
          ),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey,
          backgroundColor: const Color(PrimaryColors.primaryBackgroundColor),
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.album),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.airplane_ticket_rounded),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'School',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'School',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blueAccent,
          onTap: _onItemTapped,
        ),
      ),
      backgroundColor: const Color(PrimaryColors.primaryBackgroundColor),
    );
  }
}
