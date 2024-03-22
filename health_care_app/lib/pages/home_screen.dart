import 'package:flutter/material.dart';
import 'package:health_care_app/pages/AllAppoinments.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care_app/utils/app_constants.dart';
import 'package:health_care_app/utils/my_timeline_tile.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> happyQuotes = [
    "Happiness is not something ready made. It comes from your own actions. - Dalai Lama",
    "The only way to be happy is to love. Unless you love, your life will flash by. - Tree of Life",
    "The most important thing is to enjoy your life - to be happy. It's all that matters. - Audrey Hepburn",
    "Happiness is not by chance, but by choice. - Jim Rohn",
    "The happiness of your life depends upon the quality of your thoughts. - Marcus Aurelius",
    "Happiness is a choice, not a result. Nothing will make you happy until you choose to be happy. - Ralph Marston",
    "The only thing that will make you happy is being happy with who you are. - Goldie Hawn",
    "The best way to cheer yourself is to try to cheer someone else up. - Mark Twain",
    "Happiness is not something you postpone for the future; it is something you design for the present. - Jim Rohn",
    "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful. - Albert Schweitzer",
  ];

  List<String> sadQuotes = [
    "Tears are words that need to be written. - Paulo Coelho",
    "The way sadness works is one of the strange riddles of the world. - Lemony Snicket",
    "The word 'happiness' would lose its meaning if it were not balanced by sadness. - Carl Jung",
    "Sadness flies away on the wings of time. - Jean de La Fontaine",
    "Don't cry because it's over, smile because it happened. - Dr. Seuss",
    "You cannot protect yourself from sadness without protecting yourself from happiness. - Jonathan Safran Foer",
    "Behind every sweet smile, there is a bitter sadness that no one can ever see and feel. - Tupac Shakur",
    "The greater your capacity to love, the greater your capacity to feel the pain. - Jennifer Aniston",
    "Sometimes you laugh because you’ve got no more room for crying. - Terry Pratchett",
    "When you are joyous, look deep into your heart and you shall find it is only that which has given you sorrow that is giving you joy. - Khalil Gibran",
  ];
  List<String> illQuotes = [
    "A positive attitude is most easily arrived at through a deliberate and rational analysis of what’s required to manifest unwavering positive emotion. - Dalai Lama",
    "It's not all sunshine and rainbows, but a good amount of it actually is. - Unknown",
    "I'm not afraid of storms, for I'm learning how to sail my ship. - Louisa May Alcott",
    "The only courage that matters is the kind that gets you from one moment to the next. - Mignon McLaughlin",
    "The biggest disease today is not leprosy or tuberculosis, but rather the feeling of being unwanted. - Mother Teresa",
    "You have within you right now, everything you need to deal with whatever the world can throw at you. - Brian Tracy",
    "A setback is only a setup for a comeback. - Unknown",
    "Strength does not come from physical capacity. It comes from an indomitable will. - Mahatma Gandhi",
    "Just because you’re struggling doesn’t mean you’re failing. - Unknown",
    "Life is a shipwreck but we must not forget to sing in the lifeboats. - Voltaire",
  ];
  String selectedQuote = '';
  bool isHappy = true;
  bool isSad = false;
  bool isIll = false;
  void selectQuote() {
    if (isHappy) {
      selectedQuote = happyQuotes[Random().nextInt(happyQuotes.length)];
    } else if (isSad) {
      selectedQuote = sadQuotes[Random().nextInt(sadQuotes.length)];
    } else if (isIll) {
      selectedQuote = illQuotes[Random().nextInt(illQuotes.length)];
    }
  }

  late AnimationController _controller;
  double _fillPercentage = 0.0;
  double calculateBMI(double height, double weight) {
    // Formula to calculate BMI: weight (kg) / (height (m) * height (m))
    return weight / ((height / 100) * (height / 100));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //     _controller = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 500),
    // );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void _fillHeart() {
    setState(() {
      if (_fillPercentage < 100) {
        _fillPercentage += 5;
        _controller.forward(from: 0); // Trigger animation
        print("this is fill: " + _fillPercentage.toString());
      }
      if (_fillPercentage >= 50) {
        print("what is this : " + _fillPercentage.toString());
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    bool sleptWell = true;
    double height = 174;
    double weight = 59;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: ListView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Good Morning!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.notification_add,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 2000),
                    child: Padding(
                      key: Key(selectedQuote),
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Tip for the day: ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                selectedQuote,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Stack(
                      children: [
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.deepPurpleAccent.shade100,
                          ),
                        ),
                        Positioned(
                          top: 50,
                          left: 8,
                          child: GestureDetector(
                            onTap: () {
                              _fillHeart();
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: Icon(Icons.add),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              _fillHeart();
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      height: MediaQuery.of(context).size.height / 2.5,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppConstants.myOrange,
                                      borderRadius: BorderRadius.circular(25)),
                                  height: 150,
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Steps ",
                                              style: TextStyle(fontSize: 25),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Icon(
                                              Icons.run_circle_rounded,
                                              size: 70,
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FaIcon(FontAwesomeIcons.fire),
                                          Center(
                                              child: Text(
                                            "8,696",
                                            style: TextStyle(fontSize: 32),
                                          )),
                                          FaIcon(FontAwesomeIcons.fire),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppConstants.myOrange),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("BMI: ",
                                              style: TextStyle(fontSize: 20)),
                                        ),
                                        Text(
                                          "${calculateBMI(height, weight).toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 70,
                                      width: 180,
                                      decoration: BoxDecoration(
                                          color: AppConstants.lightYellow,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Calories burned ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "2,069",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 90,
                                      width: 220,
                                      decoration: BoxDecoration(
                                        color: AppConstants.sleepColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.bed,
                                            size: 40,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "6",
                                            style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            "h",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            "20",
                                            style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text("m"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          sleptWell
                                              ? FaIcon(
                                                  FontAwesomeIcons.faceLaugh,
                                                  color:
                                                      AppConstants.primaryColor,
                                                  size: 60,
                                                )
                                              : FaIcon(
                                                  FontAwesomeIcons.faceFlushed,
                                                  color:
                                                      AppConstants.primaryColor,
                                                ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isHappy = true;
                                              isSad = false;
                                              isIll = false;
                                              selectedQuote = happyQuotes[
                                                  Random().nextInt(
                                                      happyQuotes.length)];
                                            });
                                            print('he is happy');
                                          },
                                          child: FaIcon(
                                            FontAwesomeIcons.faceLaughBeam,
                                            size: isHappy
                                                ? 55
                                                : 35, // Increase size if isHappy is true
                                            color: isHappy
                                                ? Colors.orange
                                                : null, // Change color to orange if isHappy is true
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isHappy = false;
                                              isSad = true;
                                              isIll = false;
                                              selectedQuote = sadQuotes[Random()
                                                  .nextInt(sadQuotes.length)];
                                            });
                                            print("he is sad");
                                          },
                                          child: FaIcon(
                                            FontAwesomeIcons.faceFrown,
                                            size: isSad
                                                ? 65
                                                : 40, // Increase size if isSad is true
                                            color: isSad
                                                ? Colors.orange
                                                : null, // Change color to orange if isSad is true
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isHappy = false;
                                              isSad = false;
                                              isIll = true;
                                              selectedQuote = illQuotes[Random()
                                                  .nextInt(illQuotes.length)];
                                            });
                                            print("he is sad");
                                          },
                                          child: FaIcon(
                                            FontAwesomeIcons.faceSadTear,
                                            size: isIll
                                                ? 65
                                                : 40, // Increase size if isIll is true
                                            color: isIll
                                                ? Colors.orange
                                                : null, // Change color to orange if isIll is true
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: Container(
                                  height: 170,
                                  width: 165,
                                  decoration: BoxDecoration(
                                      color: AppConstants.lightYellow,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Text(
                                        "App Usage",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: 8,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                  child: Row(
                                                    children: [
                                                      FaIcon(FontAwesomeIcons
                                                          .instagram),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text("5h 55m"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      // height: MediaQuery.of(context).size.height / 2.5,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        MedicalHistoryPage()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Center(
                                              child: Text(
                                        "Medical History",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ))),
                                      InkWell(child: Text("see all")),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
                                          child:
                                              Icon(Icons.view_agenda_outlined),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
