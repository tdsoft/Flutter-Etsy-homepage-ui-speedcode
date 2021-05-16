import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Etsy',
      theme: ThemeData.light(),
      home: MyHomePage(title: 'Etsy Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Color(0xffececec),
        title: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search for anything in Etsy"),
        ),
        leading: Icon(
          Icons.search_outlined,
          color: Colors.black,
        ),
      ),
      body: IndexedStack(
        index: _index,
        children: [
          Container(
            color: Colors.white,
            child: ListView.builder(
                itemCount: getListItems().length,
                itemBuilder: (context, index) {
                  final item = getListItems()[index];
                  return _showListItem(item);
                }),
          ),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.amberAccent,
          ),
          Container(
            color: Colors.pinkAccent,
          ),
          Container(
            color: Colors.teal,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) {
          setState(() {
            _index = i;
          });
        },
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_filled),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: "Favorites"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none),
              activeIcon: Icon(Icons.notifications),
              label: "Updates"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: "You"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart),
              label: "Cart"),
        ],
      ),
    );
  }

  Widget _showListItem(ListItem item) {
    var size = MediaQuery.of(context).size;
    switch (item.getListItemType()) {
      case ListItemType.FlashSalesCard:
        final flashSalesCardItem = item as FlashSalesCard;
        return _loadFlashSalesCard(flashSalesCardItem);
      case ListItemType.ImageCard:
        final imageCard = item as ImageCard;
        return _loadImageCard(size, imageCard);
      case ListItemType.TwoColumnGrid:
        final twoColumnGrid = item as TwoColumnGrid;
        return _loadTwoColumnGrid(size, twoColumnGrid);
      case ListItemType.TwoColumnList:
        final twoColumnList = item as TwoColumnList;
        return _loadTwoColumnList(twoColumnList);
    }
  }

  Widget _loadFlashSalesCard(FlashSalesCard flashSalesCardItem) {
    return Container(
      height: 150,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: double.infinity,
              height: 100,
              child: Image.asset(
                "assets/images/top_back_image.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8, top: 16),
              height: 150,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(0xff1b4720),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        flashSalesCardItem.title,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        flashSalesCardItem.description,
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Shop now",
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 18,
                            color: Colors.white,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  } //done

  Widget _loadImageCard(Size size, ImageCard imageCard) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Container(
          height: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Image.asset(
                imageCard.image,
                fit: BoxFit.cover,
              )),
              Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                        child: Text(
                          imageCard.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0, bottom: 8),
                        child: Row(
                          children: [
                            RatingBarIndicator(
                              rating: 5,
                              itemCount: 5,
                              itemSize: 16,
                              unratedColor: Colors.amber.withAlpha(50),
                              direction: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Icon(
                                  Icons.star,
                                  color: Colors.black,
                                );
                              },
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text("(299) Reviews")
                          ],
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.favorite_border_outlined),
                  SizedBox(
                    width: 8,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  } //Done

  Widget _loadTwoColumnGrid(Size size, TwoColumnGrid twoColumnGrid) {
    //24 is for status bar height
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width;
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Our picks for you",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Tap")));
                  },
                  child: Container(
                    child: Text(
                      'See more',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                )
              ],
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: (itemWidth / itemHeight),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: twoColumnGrid.images.map((image) {
              return Stack(
                children: [
                  Positioned.fill(
                      child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
                  Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.white,
                      ))
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  } //Done

  Widget _loadTwoColumnList(TwoColumnList twoColumnList) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      height: 140,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.vertical,
          children: twoColumnList.images.map((image) {
            return SizedBox(
              width: 200,
              height: 60,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(
                  children: [
                    Image.asset(
                      image.image,
                      width: 50,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        image.title,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

List<ListItem> getListItems() {
  return [
    FlashSalesCard("App flash sale Get 20% off",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry"),
    ImageCard(
        "Image 01",
        "Lorem Ipsum is simply dummy text of the printing "
            "and typesetting industry. Lorem Ipsum has been the industry's "
            "standard dummy text ever since the 1500s, when an unknown "
            "printer took a galley of type and scrambled it to make a type specimen book.",
        "assets/images/image1.jpg"),
    TwoColumnGrid([
      "assets/images/image1.jpg",
      "assets/images/image2.jpg",
      "assets/images/image3.jpg",
      "assets/images/image4.jpg",
      "assets/images/image4.jpg",
      "assets/images/image3.jpg",
    ]),
    TwoColumnList([
      ImageWithTitle("Image 01", "assets/images/image1.jpg"),
      ImageWithTitle("Image 02", "assets/images/image2.jpg"),
      ImageWithTitle("Image 03", "assets/images/image3.jpg"),
      ImageWithTitle("Image 04", "assets/images/image4.jpg"),
      ImageWithTitle("Image 01", "assets/images/image1.jpg"),
      ImageWithTitle("Image 02", "assets/images/image2.jpg"),
      ImageWithTitle("Image 03", "assets/images/image3.jpg"),
      ImageWithTitle("Image 04", "assets/images/image4.jpg")
    ])
  ];
}
