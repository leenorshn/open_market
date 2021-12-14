import 'package:flutter/material.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({Key? key}) : super(key: key);

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, bool isScrolling) {
          return [
            SliverOverlapAbsorber(
              // This widget takes the overlapping behavior of the SliverAppBar,
              // and redirects it to the SliverOverlapInjector below. If it is
              // missing, then it is possible for the nested "inner" scroll view
              // below to end up under the SliverAppBar even when the inner
              // scroll view thinks it has not been scrolled.
              // This is not necessary if the "headerSliverBuilder" only builds
              // widgets that do not overlap the next sliver.
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                //his is the title in the app bar.
                pinned: true,
                floating: true,
                expandedHeight: 250.0,
                forceElevated: isScrolling,

                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    "images/tomato.jpg",
                    fit: BoxFit.cover,
                  ),
                  title: const Text(
                    'Product',
                    style: TextStyle(color: Colors.black),
                  ), // T,
                ),
              ),
            )
          ];
        },
        body: ListView.builder(
          itemBuilder: (context, index) {
            return const Text("Ok");
          },
        ),
      ),
    );
  }
}
