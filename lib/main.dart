import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/api/urls.dart';
import 'package:food_app/colours/Colours.dart';
import 'package:food_app/models/User.dart';
import 'package:http/http.dart' as http;

import 'models/Recipe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF264B61),
        bottomAppBarColor: const Color(0xFF264B61),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF264B61),
          secondary: const Color(0xFF16354E),
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 33.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline2: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline3: TextStyle(fontSize: 20.0, color: Colors.grey),
          headline4: TextStyle(
              fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),
          bodyText1: TextStyle(fontSize: 14.0, color: Colors.white),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var user = User(name: "Connor", surname: "Smith", mail: "cs@gmail.com");
  int colorIndex = 0;
  Response? response;
  List<Results>? results;

  Future getFeed() async {
    if (response == null) {
      http.Response res = await http.get(Uri.parse(feedUrl));

      if (res.statusCode == 200) {
        Map<String, dynamic> resjson = json.decode(res.body);
        // UserResponse userResponse = UserResponse.fromJson(resjson);
        Response response1 = Response.fromJson(resjson);
        setState(() {
          response = response1;
          results = response?.results;
        });
      } else {
        print("OMG Internet no worke!");
        print(res.body);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getFeed();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text(""),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 30,
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              "Hi, ${user.name}",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text("What do you want to cook today?",
                style: Theme.of(context).textTheme.headline1),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: const Icon(Icons.search)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text("Most Popular Recipes",
                style: Theme.of(context).textTheme.headline2),
          ),
          if (response != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                height: 350,
                child: ListView.builder(
                    // itemCount: response?.results![0].items!.length,
                    itemCount: results![0].items!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, index) {
                      Color curr = colours[colorIndex];
                      colorIndex++;
                      if (colorIndex >= colours.length) {
                        colorIndex = 0;
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          width: 280,
                          decoration: BoxDecoration(
                            color: curr,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 250,
                                margin: EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    image: NetworkImage(results![0]
                                        .items![index]
                                        .thumbnailUrl!),
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      results![0].items![index].name!,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                      textAlign: TextAlign.center,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.access_time,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "${results![0].items![index].cookTimeMinutes ?? 0} mins",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "${results![0].items![index].numServings!} servings",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ] else ...[
            Container(
              height: 300,
              child: const Center(
                child: SpinKitRotatingCircle(
                  color: Colors.white,
                  size: 50,
                ),
              ),
            )
          ]
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: const Color(0xFF264B61),
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.yellow))),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border_sharp), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: "home"),
          ],
        ),
      ),
    );
  }
}
