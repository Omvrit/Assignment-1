import 'package:assignment/Cache/AutoCompletionData.dart';
import 'package:assignment/Cache/commodity.dart';
import 'package:assignment/Cache/container_sizes.dart';
import 'package:assignment/HttpMethods/api_for_auto_completing_location_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  ApiForAutoCompletingLocationField.loadTheEntriesForAutoCompletion();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.robotoTextTheme()),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController dateController =
      TextEditingController(); //we are controlling text field using controller

  TextEditingController originEditingController = TextEditingController();

  TextEditingController destinationEditingController = TextEditingController();
  TextEditingController ContainerSizeEditingController =
      TextEditingController();
  TextEditingController noOfBoxesEditingController = TextEditingController();
  TextEditingController weightEditingController = TextEditingController();
  TextEditingController commodityEditingController = TextEditingController();
  TextEditingController containerSizeEditingController =
      TextEditingController();

  late bool nearbyOrigin = false;

  late bool nearbyDestination = false;

  late bool fcl = true;

  late bool lcl = true;

  late String containerSize;

  late String noOfBoxes;

  late int weight;
  Image image = Image.asset("/assets/container");

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.all(3.0),
            child: Text(
              "Search the best Freight Rates",
              style: TextStyle(
                  fontSize: 16, height: 30, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 18, 0),
              child: IconButton(
                  onPressed: () {},
                  icon: TextButton.icon(
                      onPressed: () {}, // Define the button's action here

                      label: const Text(
                        'History',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color.fromRGBO(
                                1, 57, 255, 1)), // Blue text color
                      ),
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 9, horizontal: 17),
                          backgroundColor: Color.fromRGBO(230, 235, 255, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          side: const BorderSide(
                            width: 1,
                            color: Color.fromRGBO(1, 57, 255, 1),
                          ) // Button padding

                          ))),
            )
          ],
          backgroundColor: const Color.fromRGBO(243, 245, 252, 1),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: const Color.fromRGBO(230, 234, 248, 1),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(35, 16, 35, 50),
              child: Card(
                color: const Color.fromRGBO(255, 255, 255, 1),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 40, 20, 5),
                      child: Row(
                        children: [
                          //First Entry for OriginLocation ---------------------------------
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Column(
                                children: [
                                  Autocomplete<String>(
                                    optionsBuilder:
                                        (TextEditingValue textEditingValue) {
                                      // List of suggestions for the Autocomplete field
                                      final List<String> suggestions = [];
                                      for (var entry in li) {
                                        String? name = entry.name;
                                        suggestions.add(name!);
                                      }

                                      if (textEditingValue.text.isEmpty) {
                                        return const Iterable<String>.empty();
                                      }
                                      return suggestions
                                          .where((String suggestion) {
                                        return suggestion
                                            .toLowerCase()
                                            .contains(textEditingValue.text
                                                .toLowerCase());
                                      });
                                    },
                                    fieldViewBuilder: (BuildContext context,
                                        TextEditingController
                                            textEditingController,
                                        FocusNode focusNode,
                                        VoidCallback onFieldSubmitted) {
                                      return TextField(
                                        controller: textEditingController,
                                        focusNode: focusNode,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromRGBO(
                                                  246, 246, 246, 1),
                                              width:
                                                  2.0, // Border color when the TextField is not focused
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                8.0), // Added 8 radius
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                              width:
                                                  2.0, // Border color when the TextField is focused
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                8.0), // Added 8 radius
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                8.0), // Added 8 radius
                                          ),
                                          label: const Text(
                                            "Origin",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  119, 116, 123, 1),
                                            ),
                                          ),
                                          prefixIcon: const ImageIcon(
                                              AssetImage(
                                                  "assets/location.png")),
                                        ),
                                      );
                                    },
                                    onSelected: (String selection) {
                                      debugPrint('You selected: $selection');
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: nearbyOrigin,
                                        onChanged: (value) {
                                          setState(() {
                                            nearbyOrigin = !nearbyOrigin;
                                          });
                                        },
                                        activeColor: const Color.fromRGBO(
                                            21, 94, 239, 1),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        side: const BorderSide(width: .1),
                                      ),
                                      const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(6, 0, 0, 0),
                                          child: Text(
                                            "Include nearby origin ports",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w100),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          //Second Entry for Destination ---------------------------------
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Column(
                                children: [
                                  Autocomplete<String>(
                                    optionsBuilder:
                                        (TextEditingValue textEditingValue) {
                                      // List of suggestions for the Autocomplete field
                                      final List<String> suggestions = [];
                                      for (var entry in li) {
                                        String? name = entry.name;
                                        suggestions.add(name!);
                                      }

                                      if (textEditingValue.text.isEmpty) {
                                        return const Iterable<String>.empty();
                                      }
                                      return suggestions
                                          .where((String suggestion) {
                                        return suggestion
                                            .toLowerCase()
                                            .contains(textEditingValue.text
                                                .toLowerCase());
                                      });
                                    },
                                    fieldViewBuilder: (BuildContext context,
                                        TextEditingController
                                            textEditingController,
                                        FocusNode focusNode,
                                        VoidCallback onFieldSubmitted) {
                                      return TextField(
                                        controller: textEditingController,
                                        focusNode: focusNode,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromRGBO(
                                                  246, 246, 246, 1),
                                              width:
                                                  2.0, // Border color when the TextField is not focused
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                8.0), // Added 8 radius
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                              width:
                                                  2.0, // Border color when the TextField is focused
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                8.0), // Added 8 radius
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                8.0), // Added 8 radius
                                          ),
                                          label: const Text(
                                            "Destination",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  119, 116, 123, 1),
                                            ),
                                          ),
                                          prefixIcon: const ImageIcon(
                                              AssetImage(
                                                  "assets/location.png")),
                                        ),
                                      );
                                    },
                                    onSelected: (String selection) {
                                      debugPrint('You selected: $selection');
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: nearbyDestination,
                                        onChanged: (value) {
                                          setState(() {
                                            nearbyDestination =
                                                !nearbyDestination;
                                          });
                                        },
                                        activeColor: const Color.fromRGBO(
                                            21, 94, 239, 1),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        side: const BorderSide(width: .1),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(6, 0, 0, 0),
                                        child: Text(
                                          "Include nearby destination ports",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w100),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Row(
                        children: [
                          //Drop down menu for getting Commodity ------------------------

                          Expanded(
                              child: DropdownMenu<String>(
                            onSelected: (value) {
                              setState(() {
                                commodityEditingController.text = value!;
                              });
                            },
                            controller: commodityEditingController,
                            dropdownMenuEntries: commodityNames
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList(),
                            trailingIcon:
                                Icon(Icons.keyboard_arrow_down_rounded),
                            inputDecorationTheme: InputDecorationTheme(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(246, 246, 246, 1),
                                  width:
                                      2.0, // Border color when the TextField is not focused
                                ),
                                borderRadius: BorderRadius.circular(
                                    8.0), // Added 8 radius
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width:
                                      2.0, // Border color when the TextField is focused
                                ),
                                borderRadius: BorderRadius.circular(
                                    8.0), // Added 8 radius
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Added 8 radius
                              ),
                            ),
                            label: const Text(
                              "Commodity",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(99, 96, 105, 1)),
                            ),
                            width: 700,
                          )),
                          const SizedBox(
                            width: 20,
                          ),
                          //Getting input for Date -------------------------------
                          Expanded(
                              child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: TextField(
                                controller: dateController,
                                onTap: () async {
                                  DateTime? date = (await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2050)))!;
                                  if (date != DateTime.now()) {
                                    setState(() {
                                      dateController.text = "${date.toLocal()}"
                                          .split(' ')[0]; // Format date
                                    });
                                  }
                                },
                                readOnly: true,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(246, 246, 246, 1),
                                        width:
                                            2.0, // Border color when the TextField is not focused
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Added 8 radius
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width:
                                            2.0, // Border color when the TextField is focused
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Added 8 radius
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Added 8 radius
                                    ),
                                    label: const Text(
                                      "Cut Off Date",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromRGBO(99, 96, 105, 1)),
                                    ),
                                    suffixIcon: const ImageIcon(
                                        AssetImage("assets/cal.png"))),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Row(
                        children: [
                          Text(
                            "Shipment Type :",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: fcl,
                                onChanged: (value) {
                                  setState(() {
                                    fcl = !fcl;
                                  });
                                },
                                activeColor:
                                    const Color.fromRGBO(21, 94, 239, 1),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                side: const BorderSide(width: .1),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                child: Text(
                                  "FCL",
                                  style: TextStyle(fontWeight: FontWeight.w100),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: lcl,
                                onChanged: (value) {
                                  setState(() {
                                    lcl = !lcl;
                                  });
                                },
                                activeColor:
                                    const Color.fromRGBO(21, 94, 239, 1),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                side: const BorderSide(width: .1),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                child: Text(
                                  "LCL",
                                  style: TextStyle(fontWeight: FontWeight.w100),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: DropdownMenu<String>(
                              initialSelection: "40’ Standard",
                              controller: containerSizeEditingController,
                              onSelected: (value) {
                                containerSizeEditingController.text =
                                    value.toString();
                              },
                              trailingIcon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              label: const Text("Container Size",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(119, 116, 123, 1))),
                              inputDecorationTheme: InputDecorationTheme(
                                labelStyle: const TextStyle(
                                    color: Color.fromRGBO(217, 217, 217, 1)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(246, 246, 246, 1),
                                    width:
                                        2.0, // Border color when the TextField is not focused
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Added 8 radius
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width:
                                        2.0, // Border color when the TextField is focused
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Added 8 radius
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Added 8 radius
                                ),
                              ),
                              width: 700,
                              dropdownMenuEntries: containerSizes
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
                                return DropdownMenuEntry<String>(
                                    value: value, label: value);
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: noOfBoxesEditingController,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(246, 246, 246, 1),
                                        width:
                                            2.0, // Border color when the TextField is not focused
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Added 8 radius
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width:
                                            2.0, // Border color when the TextField is focused
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Added 8 radius
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Added 8 radius
                                    ),
                                    label: const Text("No. of Boxes",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromRGBO(
                                                119, 116, 123, 1)))),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: TextField(
                                controller: weightEditingController,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(246, 246, 246, 1),
                                        width:
                                            2.0, // Border color when the TextField is not focused
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Added 8 radius
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width:
                                            2.0, // Border color when the TextField is focused
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Added 8 radius
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Added 8 radius
                                    ),
                                    label: const Text("Weight(kg)",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromRGBO(
                                                119, 116, 123, 1)))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 6, 20, 15),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.exclamationmark_circle),
                          SizedBox(width: 10),
                          Expanded(
                              child: Text(
                            "To obtain accurate rate for spot rate with guaranteed space and booking, please ensure your container count and weight per container is accurate.",
                            style: TextStyle(fontSize: 15),
                          ))
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
                      child: Row(
                        children: [
                          Text(
                            "Container Internal Dimensions :",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 25),
                      child: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Length",
                                      style: TextStyle(
                                        fontSize: 13,
                                          color:
                                              Color.fromRGBO(170, 170, 170, 1)),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("Width",


                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color.fromRGBO(
                                                170, 170, 170, 1))),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("Height",

                                        style: TextStyle(
                                            fontSize: 13,

                                            color: Color.fromRGBO(
                                                170, 170, 170, 1)))
                                  ],
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "39.46ft",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("7.70ft",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("7.84ft",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                                const SizedBox(width: 35,),
                                Column(
                                  children: [
                                  Image.asset(
                                  'assets/container1.jpg',  // Path to your image
                                  width: 200,  // Set the width of the image
                                  height: 80, // Set the height of the image
                                  fit: BoxFit.cover,  // BoxFit to control the image fit
                                )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            // Define the button's action here
                            iconAlignment: IconAlignment.start,
                            icon: Icon(
                              CupertinoIcons.search,
                              color: Color.fromRGBO(1, 57, 255, 1),
                              opticalSize: 2,
                            ),
                            // Search icon
                            label: const Text(
                              'Search',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(
                                      1, 57, 255, 1)), // Blue text color
                            ),
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10),
                                backgroundColor:
                                    Color.fromRGBO(230, 235, 255, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.blue,
                                ) // Button padding

                                ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
