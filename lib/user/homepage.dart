import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  List imageList=[
    "assets/image 1.png",
    "assets/image 2.png",
    "assets/image 3.png",
    "assets/image 4.png",
    "assets/image 5.png",
    "assets/image 6.png",
    "assets/image 7.png",
    "assets/image 8.png",
    "assets/image 9.png",
    "assets/image 10.png",
    "assets/image 11.png",
    "assets/image 12.png",
    "assets/image 13.png",
    "assets/image 14.png",
    "assets/image 15.png",
    "assets/image 16.png",
    "assets/image 17.png",
  ];

  Future<List<String>> fetchData(String num) async {
    FirebaseService firebaseService = FirebaseService();

    List<String> ngoData = await firebaseService.getAllNgos();
    final List<String> names = [];

    for (String ngo in ngoData) {
      List<String> arrayData = await firebaseService.getArrayData(ngo);
      for (String ele in arrayData) {
        if (ele == num) {
          names.add(await firebaseService.getNgoName(ngo));
          break;
        }
      }
    }

    return names;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(width: 3),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(child: Text("GAIA'S TOUCH",style: TextStyle(fontFamily: 'Habibi'),)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('SELECT YOUR TARGETED GOAL',style: TextStyle(fontFamily: 'InterBlack',color: Colors.lightBlueAccent,fontSize: 30),),
            ),
           Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               InkWell(
                   child: Image(image: AssetImage(imageList[0]),height: 90,),
                 onTap: () async {
                   List<String> names = await fetchData("no poverty");
                   openDialog(names,"1. NO POVERTY");

                 },
               ),
               InkWell(
                   child: Image(image: AssetImage(imageList[1]),height: 90,),
                 onTap: () async {
                   List<String> names = await fetchData("zero hunger");
                   openDialog(names,"2. ZERO HUNGER");
                 },
               ),
               InkWell(
                 child: Image(image: AssetImage(imageList[2]),height: 90,),
                 onTap: () async {
                   List<String> names = await fetchData("good health & well-being");
                   openDialog(names,"3. GOOD HEALTH & WELL-BEING");
                 },
               ),
             ],
           ),
            SizedBox(height: 15,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  child: Image(image: AssetImage(imageList[3]),height: 90,),
                  onTap: () async {
                    List<String> names = await fetchData("quality education");
                    openDialog(names,"4. QUALITY EDUCATION");

                  },
                ),
                InkWell(
                  child: Image(image: AssetImage(imageList[4]),height: 90,),
                  onTap: () async {
                    List<String> names = await fetchData("gender equality");
                    openDialog(names,"5. GENDER EQUALITY");
                  },
                ),
                InkWell(
                  child: Image(image: AssetImage(imageList[5]),height: 90,),
                  onTap: () async {
                    List<String> names = await fetchData("clean water & sanitation");
                    openDialog(names,"6. CLEAN WATER & SANITATION");
                  },
                ),
              ],
            ),
            SizedBox(height: 15,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  child: Image(image: AssetImage(imageList[6]),height: 90,),
                  onTap: () async {
                    List<String> names = await fetchData("affordable & clean energy");
                    openDialog(names,"7. AFFORDABLE & CLEAN ENERGY");
                  },
                ),
                InkWell(
                  child: Image(image: AssetImage(imageList[7]),height: 90,),
                  onTap: () async {
                    List<String> names = await fetchData("decent work & economic growth");
                    openDialog(names,"8. DECENT WORK & ECONOMIC GROWTH");
                  },
                ),
                InkWell(
                  child: Image(image: AssetImage(imageList[8]),height: 90,),
                  onTap: () async {
                    List<String> names = await fetchData("industry, innovation & infrastructure");
                    openDialog(names,"9. INDUSTRY, INNOVATION & INFRASTRUCTURE");
                  },
                ),
              ],
            ),
            SizedBox(height: 15,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  child: Image(image: AssetImage(imageList[9]),height: 90,),
                  onTap: () async {
                    List<String> names = await fetchData("reduced inequalities");
                    openDialog(names,"10. REDUCED INEQUALITIES");
                  },
                ),
                InkWell(
                  child: Image(image: AssetImage(imageList[10]),height: 90,),
                  onTap: () async {
                    List<String> names = await fetchData("sustainable cities & communities");
                    openDialog(names,"11. SUSTAINABLE CITIES & COMMUNITIES");
                  },
                ),
                InkWell(
                  child: Image(image: AssetImage(imageList[11]),height: 90,),
                  onTap: () async {
                    List<String> names = await fetchData("responsible consumption & production");
                    openDialog(names,"12. RESPONSIBLE CONSUMPTION & PRODUCTION");
                  },
                ),
              ],

            ),
            SizedBox(height: 15,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  child: Image(image: AssetImage(imageList[12]),height: 90,),
                  onTap: () async {
                    List<String> names = await fetchData("climate action");
                    openDialog(names,"13. CLIMATE ACTION");
                  },
                ),                InkWell(
                  child: Image(image: AssetImage(imageList[13]),height: 90,),
                  onTap: () async {
                    List<String> names = await fetchData("life below water");
                    openDialog(names,"14. LIFE BELOW WATER");
                  },
                ),                InkWell(
                  child: Image(image: AssetImage(imageList[14]),height: 90,),
                  onTap: () async {
                    List<String> names = await fetchData("life on land");
                    openDialog(names,"15. LIFE ON LAND");
                  },
                ),
              ],
            ),
            SizedBox(height: 15,),
           Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: Image(image: AssetImage(imageList[15]),height: 90,),
                  onTap: () async {
                    List<String> names = await fetchData("peace, justice and strong institutions");
                    openDialog(names,"16. PEACE, JUSTICE AND STRONG INSTITUTIONS");
                  },
                ),
                InkWell(
                  child: Image(image: AssetImage(imageList[16]),height: 90,),
                  onTap: () async {
                    List<String> names = await fetchData("partnerships for the goals");
                    openDialog(names,"17. PARTNERSHIPS FOR THE GOALS");
                  },
                ),
              ],
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
  Future openDialog(List<String> names,String title) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, style: TextStyle(color: Colors.white, fontFamily: 'InterBlack'),),
      backgroundColor: Colors.redAccent,
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: names.map((name) => SizedBox(
            width: double.infinity,
            child: RoundedButtonWidget(buttonText: name, width: double.infinity, onpressed: () {}, onpressed2: () {},),
          )).toList(),
        ),
      ),
    ),
  );
}
class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final double width;
  final Function onpressed;
  final Function onpressed2;

  RoundedButtonWidget({
    required this.buttonText,
    required this.width,
    required this.onpressed,
    required this.onpressed2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 5.0,
            )
          ],
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
            minimumSize: MaterialStateProperty.all<Size>(Size(150, 50)), // Set a default size
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.transparent,
            ),
            shadowColor: MaterialStateProperty.all<Color>(
              Colors.transparent,
            ),
          ),
          onPressed: () {
            onpressed();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  buttonText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  onpressed2;
                },
                child: Text(
                  'CONTACT',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'InterBlack',
                    fontSize: 10,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.teal.shade300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
