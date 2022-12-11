import 'package:clean_block_floor_lint_dio/core/widgets/app_background.dart';
import 'package:clean_block_floor_lint_dio/core/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import '../../features/feature_bookmark/presentation/screens/bookmark_screen.dart';
import '../../features/feature_weather/presentation/screens/home_screen.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});
  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    List<Widget> pageViewWidget = [
      const HomeScreen(),
      const BookMarkScreen(),
    ];
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNav(Controller: pageController),
      body: Container(
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AppBackground.getBackGroundImage(),
            fit: BoxFit.cover,
          ),
        ),
        child: PageView(
          controller: pageController,
          children: pageViewWidget,
        ),
      ),
    );
  }
}


















// class MainWrapper extends StatefulWidget {
//   const MainWrapper({Key? key}) : super(key: key);

//   @override
//   State<MainWrapper> createState() => _MainWrapperState();
// }

// class _MainWrapperState extends State<MainWrapper> {
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<HomeBloc>(context).add(const LoadCwEvent('Tehran'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: BlocBuilder<HomeBloc, HomeState>(
//         builder: (BuildContext context, HomeState state) {
//           if (state.cwStatus is CwLoading) {
//             return const Center(
//               child: Text('Loading ...'),
//             );
//           }
//           if (state.cwStatus is CwCompleted) {
//             //! Cast
//             final CwCompleted cwCompleted = state.cwStatus as CwCompleted;
//             final CurrentCityEntity currentCityEntity =
//                 cwCompleted.currentCityEntity;

//             return Center(
//               child: Text(currentCityEntity.name.toString()),
//             );
//           }
//           if (state.cwStatus is CwError) {
//             return const Center(
//               child: Text('Error'),
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }
