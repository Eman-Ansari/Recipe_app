import 'package:dbproject/horizontalbuilder/modelcard.dart';
import 'package:flutter/material.dart';

class card extends StatefulWidget {
  const card({super.key});

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<card> {
  int _selectedIndex = -1; // Initially no card is selected

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 110,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = (constraints.maxWidth - 48) / 4;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: CardData.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(2),
                    width: cardWidth,
                    decoration: BoxDecoration(
                      color: _selectedIndex == index
                          ? Colors.brown
                          : const Color.fromARGB(255, 207, 176, 165),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CardData[index].icon),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          CardData[index].name,
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
