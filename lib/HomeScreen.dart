import 'package:dbproject/horizontalbuilder/card.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dbproject/AllRecipesApi/AllRecipes.dart';
import 'package:dbproject/app.dart';
import 'package:dbproject/horizontalbuilder/modelcard.dart'; // Import your card widget here

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Check if the index is for AllRecipes and navigate accordingly
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AllRecipes()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> imageList = [
      {"id": "1", "image_path": 'images/burger.webp'},
      {"id": "2", "image_path": 'images/img1.jpg'},
      {"id": "3", "image_path": 'images/img2.jpg'},
      {"id": "4", "image_path": 'images/img3.jpg'},
      {"id": "5", "image_path": 'images/img4.jpg'},
    ];

    final CarouselController _carouselController = CarouselController();

    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 216, 220, 223),
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: const Color.fromARGB(255, 139, 24, 24)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            UserAccountsDrawerHeader(
              accountName: Text("EMAN"),
              accountEmail: Text("pcemanansari@gmail.com"),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt),
              title: Text('All Recipes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllRecipes()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Gemini ChatBot'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('LogOut'),
              onTap: () {},
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 230, 224, 224),
      appBar: MyAppBar(),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Image.asset(
              'images/burger.webp',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Column(
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      print(_currentIndex);
                    },
                    child: CarouselSlider(
                      items: imageList
                          .map(
                            (item) => Container(
                              margin: EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  item['image_path']!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 2,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imageList.asMap().entries.map((entry) {
                        final int index = entry.key;
                        return GestureDetector(
                          onTap: () => _carouselController.animateToPage(index),
                          child: Container(
                            width: _currentIndex == index ? 17 : 7,
                            height: 7.0,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 3.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _currentIndex == index
                                  ? Colors.grey
                                  : const Color.fromARGB(0, 196, 170, 170),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 149, 183, 211),
                    ),
                    hintText: 'Find your Recipe',
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(121, 85, 72, 1)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(121, 85, 72, 1)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: card(), // Your card widget goes here
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
