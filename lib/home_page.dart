import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String finalhour = "";
  TextEditingController thoughtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Digital Clock"),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                final List<String>? items = prefs.getStringList('items') ??
                    [
                      '  no date available',
                      '  no time available',
                      '  no dec. available',
                    ];

                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Row(
                        children: [
                          Text("Saved Thoughts"),
                          IconButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              final success = await prefs.remove('items');
                            },
                            icon: Icon(Icons.delete),
                          )
                        ],
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Date: ${items![0]}"),
                          Text("Time: ${items[1]}"),
                          Text("Thought: ${items[2]}"),
                        ],
                      ),
                    ));
              },
              icon: const Icon(Icons.file_copy_sharp))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
              ),
              child: DigitalClock(
                is24HourTimeFormat: false,
                areaDecoration: const BoxDecoration(color: Colors.transparent),
                hourMinuteDigitTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                ),
                amPmDigitTextStyle:
                const TextStyle(color: Colors.pink, fontSize: 20),
                digitAnimationStyle: Curves.ease,
                areaHeight: 100,
                minuteDigitDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                secondDigitDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.green),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Center(child: const Text("Add Thought")),
                      content: Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                    "Date: ${DateTime.now().day.toString()}-"),
                                Text("${DateTime.now().month.toString()}-"),
                                Text("${DateTime.now().year.toString()}"),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                    "Time: ${(DateTime.now().hour == 00) ? finalhour = "12" : (DateTime.now().hour == 01) ? finalhour = "01" : (DateTime.now().hour == 02) ? finalhour = "02" : (DateTime.now().hour == 03) ? finalhour = "03" : (DateTime.now().hour == 04) ? finalhour = "04" : (DateTime.now().hour == 05) ? finalhour = "05" : (DateTime.now().hour == 06) ? finalhour = "06" : (DateTime.now().hour == 07) ? finalhour = "07" : (DateTime.now().hour == 08) ? finalhour = "08" : (DateTime.now().hour == 09) ? finalhour = "09" : (DateTime.now().hour == 10) ? finalhour = "10" : (DateTime.now().hour == 11) ? finalhour = "11" : (DateTime.now().hour == 12) ? finalhour = "12" : (DateTime.now().hour == 13) ? finalhour = "01" : (DateTime.now().hour == 14) ? finalhour = "02" : (DateTime.now().hour == 15) ? finalhour = "03" : (DateTime.now().hour == 16) ? finalhour = "04" : (DateTime.now().hour == 17) ? finalhour = "05" : (DateTime.now().hour == 18) ? finalhour = "06" : (DateTime.now().hour == 19) ? finalhour = "07" : (DateTime.now().hour == 20) ? finalhour = "08" : (DateTime.now().hour == 21) ? finalhour = "09" : (DateTime.now().hour == 22) ? finalhour = "10" : (DateTime.now().hour == 23) ? finalhour = "11" : finalhour = "12"}"),
                                Text(
                                    " : ${DateTime.now().minute.toString()}"),
                                Text(
                                    " : ${DateTime.now().second.toString()}"),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 100,
                              width: 300,
                              child: TextField(
                                controller: thoughtController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Thought',
                                  label: const Text("Thought"),
                                  prefixIcon: const Icon(Icons.add),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateColor.resolveWith(
                                        (states) => Colors.amber),
                              ),
                              onPressed: () async {
                                SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                                await prefs.setStringList('items', <String>[
                                  '${DateTime.now().day.toString()},${DateTime.now().month.toString()},${DateTime.now().year.toString()}',
                                  '$finalhour,${DateTime.now().minute.toString()},${DateTime.now().second.toString()}',
                                  '${thoughtController.text}',
                                ]);
                                Navigator.of(context).pop();
                              },
                              child: const Text("Save"),
                            )
                          ],
                        ),
                      ),
                    ));
              },
              child: const Text("Mark My Thought"),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
