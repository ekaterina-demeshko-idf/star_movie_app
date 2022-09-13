import 'package:flutter/material.dart';
import 'package:presentation/utils/widgets/tabbar.dart';
import 'package:shimmer/shimmer.dart';

class HomeSkelet extends StatelessWidget {
  const HomeSkelet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: 2,
          child: Expanded(
            child: Column(
              children: <Widget>[
                const TabBarContainer(),
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: Colors.blueGrey,
                    highlightColor: Colors.grey,
                    enabled: true,
                    child: TabBarView(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: (.16 / .25),
                            crossAxisCount: 2,
                            mainAxisSpacing: 30,
                          ),
                          itemCount: 6,
                          itemBuilder: (BuildContext ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 200,
                                      height: 400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.yellow,
                                      ),
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.yellow,
                                      ),
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.yellow,
                                      ),
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.yellow,
                                      ),
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.yellow,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 18,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 8,
                                        width: 24,
                                        color: Colors.white,
                                      ),
                                      const Icon(
                                        Icons.circle,
                                        size: 6,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        height: 8,
                                        width: 44,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 8,
                                        width: 24,
                                        color: Colors.white,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        const Text('hi'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
