import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Shopping List',

    theme: ThemeData(
        primarySwatch: Colors.red,
      ),

      home: const MyHomePage(title: 'Pridať položku'),
      );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
//custom tlacidlo widget
Widget numpad(String butText, Color butColor, Color txtColor) {
  return ElevatedButton(onPressed: () => {}, style: ElevatedButton.styleFrom(
    fixedSize: Size(70, 70),
    shape: CircleBorder(),
    primary: butColor,
  ), child: Text(
    butText,
    style: TextStyle(fontSize: 35, color: txtColor)
  )
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //Zapnutie klavesnice aby nevypisovalo error kvoli prekrytiu widgetov na obrazovke
//horna lista
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.settings),
  ),
      ),
//Spodna navigacna lista
      bottomNavigationBar: BottomNavigationBar( items: const[
        BottomNavigationBarItem(icon: Icon(Icons.dialpad), label: 'Pridať položku'),
        BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'zoznam'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'sumar'),
      ],

      ),
      body: Center(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children:[
//Textove polia
          Container(
          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
          child:
            const TextField(decoration: InputDecoration(
            hintText: 'Názov položky'
          ),
          ),
          ),
          Container(
          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
          child:
            const TextField(decoration: InputDecoration(
            hintText: 'Poznámka'
          ),
          ),
          ),
          const SizedBox(height: 10),
//Cena, pocet kusov
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:[
          Column(
          children:[
          Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(3),
          color: Colors.white,
          width: 230,
          child: Text("Cena (€)"),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(5),
            color: Colors.white,
            width: 230,
            child: Text("0", style: TextStyle(fontSize: 40),), 
            ),
          ],
          ),
          Column(
          children:[
          Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(3),
          color: Colors.white,
          width: 120,
          child: Text("Počet kusov"),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(5),
            color: Colors.white,
            width: 120,
            child: Text("0", style: TextStyle(fontSize: 40),), 
            ),
            ],
            ),
          ],
          ),
//Widget celkovo
          Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          padding: EdgeInsets.all(5),
          color: Colors.white,
          child: Text("Celkovo (€)"),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            padding: EdgeInsets.all(5),
            color: Colors.white,
            child: Text("0", style: TextStyle(fontSize: 40),), 
            ),
//Zaciatok tlacidiel kalkulacky
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
            numpad("7", Colors.white, Colors.black),
            numpad("8", Colors.white, Colors.black),
            numpad("9", Colors.white, Colors.black),
            numpad("⌫", Colors.red, Colors.white),
            ],
          ),
          const SizedBox(height: 10),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
            numpad("4", Colors.white, Colors.black),
            numpad("5", Colors.white, Colors.black),
            numpad("6", Colors.white, Colors.black),
            numpad("<>", Colors.black, Colors.white),
            ],
          ),
          const SizedBox(height: 10),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
            numpad("1", Colors.white, Colors.black),
            numpad("2", Colors.white, Colors.black),
            numpad("3", Colors.white, Colors.black),
            numpad("+", Colors.green, Colors.white),
            ],
          ),
          const SizedBox(height: 10),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
            numpad("0", Colors.white, Colors.black),
            numpad(",", Colors.white, Colors.black),
//Custom tlacidlo pre .99
            ElevatedButton(onPressed: () => {},
            style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            primary: Colors.white), 
            child: const Padding(padding: EdgeInsets.fromLTRB(40, 12, 40, 12),
            child: Text(",99",
            style: TextStyle(fontSize: 35, color: Colors.black),),),
            ),
            ],
          ),
//Koniec tlacidiel kalkulacky
          ],
          ),
        ),
      );
    }
  }
