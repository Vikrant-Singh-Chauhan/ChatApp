import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent[100],
      body: Container(
        margin: EdgeInsets.only(top: 30,left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset("images/wawe.png",height: 50,width: 50,),
              Text(
                "hello, ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center
              ),
              Text(
                "Vikrant",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(right: 20),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.person,color: Colors.redAccent[100]),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Welcome to",
            style: TextStyle(
                color: Colors.white60,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),) ,
    );
  }
}
