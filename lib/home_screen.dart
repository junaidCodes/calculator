import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalulatorHomeScreen extends StatefulWidget {
  const CalulatorHomeScreen({super.key});

  @override
  State<CalulatorHomeScreen> createState() => _CalulatorHomeScreenState();
}

class _CalulatorHomeScreenState extends State<CalulatorHomeScreen> {
  var userInput = '';
  var outPut = '';

  List<String> buttonText = [
    "AC",
    "C",
    "%",
    "÷",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "+",
    "="
  ];
  bool mulPress = true;
  bool dotPress = true;
  bool subPress = true;
  bool addPress = true;
  bool dividePress = true;

  bool isDarkModeEnabled = false;
  bool hide = false;
  var outPutSize = 34.0;

  @override
  Widget build(BuildContext context) {
    // themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light;
    // ),
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: isDarkModeEnabled ? Colors.black : Colors.blue

              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: isDarkModeEnabled
                    ? [
                  const Color(0xffe98a7f),
                  Colors.white,
                ]
                    : [
                  Color(0xff344488),
                  Colors.blue,
                ],
              ),
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Switch(
                          value: isDarkModeEnabled,
                          onChanged: (value) {
                            setState(() {
                              isDarkModeEnabled = value;
                            });
                          }),
                    )),
                Align( alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child:

                    Text(
                      userInput,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding( padding: EdgeInsets.only(right: 10),
                    child: Text(
                      outPut,
                      style: TextStyle(fontSize: 52, color: Colors.white),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: false,
                      itemCount: 20,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1.01,
                      ),
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              data(buttonText[index].toString());
                            });
                            print(buttonText[index].toString());
                          },
                          child: GestureDetector(
                            onTap: () {
                              inputProcess(index);
                              // obj.inputProcess(index);

                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                // color: Colors.white,
                                  border:
                                  Border.all(color: Colors.grey, width: 1)),
                              // color: Colors.green,
                              child: Center(
                                  child: Text(
                                    buttonText[index],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 40),
                                  )),
                            ),
                          ),
                        );
                        //
                      }),
                ),
                SizedBox(
                  height: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void data(String value) {
    //myController= value;
  }

  void onStateChanged(bool isDarkModeEnabled) {
    setState(() {
      this.isDarkModeEnabled = isDarkModeEnabled;
    });
  }
  String previousOperator = '';
  void inputProcess(int index) {
    switch (index) {
      case 0:
        userInput = '';
        outPut = '';
        addPress = true;
        subPress = true;
        dividePress = true;
        mulPress = true;
        dotPress = false;
        break;

      case 1:
        userInput = userInput.substring(0, userInput.length - 1).toString();
        subPress = false;
        dividePress= false;
        mulPress = false;
        addPress = false;

        break;

      case 2:
        userInput += '%';
        break;

      case 3:
        if (userInput.isNotEmpty && '+-x'.contains(userInput[userInput.length - 1])) {

          userInput = userInput.substring(0, userInput.length - 1) + '÷';
          dividePress = true;
          previousOperator = '÷';
          log("if this");
        } else {
          log("else this");

          if(userInput.isNotEmpty && !dividePress ){

            userInput += '÷';
            dividePress = true;

          }
          previousOperator = '÷';
        }


        break;


      case 4:
        dividePress = false;
        subPress = false;
        addPress = false;
        mulPress = false;

        userInput += '7';
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          userInput = '';
          outPut = '';
          userInput += '7';
        }

        break;

      case 5:
        dividePress = false;
        subPress = false;
        addPress = false;

        mulPress = false;
        userInput += '8';

        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          userInput = '';
          outPut = '';
          userInput += '8';
        }

        break;
      case 6:
        mulPress = false;
        dividePress = false;
        subPress = false;
        addPress = false;
        userInput += '9';
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          userInput = '';
          outPut = '';
          userInput += '9';
        }
        break;
      case 7:
        if (userInput.isNotEmpty && '+-x÷'.contains(userInput[userInput.length - 1])) {

          userInput = userInput.substring(0, userInput.length - 1) + 'x';
          mulPress = true;
          previousOperator = 'x';

        } else {


          if(userInput.isNotEmpty && !mulPress ){

            userInput += 'x';
            mulPress = true;

          }
          previousOperator = '÷';
        }
        // if (outPut.isNotEmpty) {
        //   userInput = outPut + 'x';
        //   outPut = '';
        //   mulPress = true;
        // } else {}
        // if (!mulPress) {
        //   mulPress = true;
        //   userInput += 'x';
        //   dotPress = false;
        // }

        break;
      case 8:
        dividePress = false;
        subPress = false;
        addPress = false;
        mulPress = false;
        userInput += '4';
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          userInput = '';
          outPut = '';
          userInput += '4';
        }
        break;
      case 9:
        dividePress = false;
        subPress = false;
        addPress = false;
        mulPress = false;
        userInput += '5';
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          userInput = '';
          outPut = '';
          userInput += '5';
        }
        break;
      case 10:
        dividePress = false;
        subPress = false;
        addPress = false;
        mulPress = false;
        userInput += '6';
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          userInput = '';
          outPut = '';
          userInput += '6';
        }
        break;
      case 11:

        if (outPut.isNotEmpty) {
          userInput = outPut + '-';
          outPut = '';
          subPress = true;
          previousOperator = '-';
        } else {
          if (userInput.isNotEmpty && '+-x÷'.contains(userInput[userInput.length - 1])) {
            // If the previous character is an operator, replace it with '-'
            userInput = userInput.substring(0, userInput.length - 1) + '-';
            previousOperator = '-';
          } else {
            if(userInput.isNotEmpty) {
              userInput += '-';

            }
            previousOperator = '-';
          }
        }
        break;
      case 12:
        dividePress = false;
        subPress = false;
        addPress = false;
        mulPress = false;
        userInput += '1';
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          userInput = '';
          outPut = '';
          userInput += '1';
        }
        break;
      case 13:
        dividePress = false;
        subPress = false;
        addPress = false;
        mulPress = false;
        userInput += '2';
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          userInput = '';
          outPut = '';
          userInput += '2';
        }
        break;
      case 14:
        dividePress = false;
        subPress = false;
        addPress = false;
        mulPress = false;
        userInput += '3';
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          userInput = '';
          outPut = '';
          userInput += '3';
        }

        break;
      case 15:
        // if (outPut.isNotEmpty) {
        //   userInput = outPut + '+';
        //   outPut = '';
        //   addPress = true;
        // } else {}
        // if (!addPress) {
        //   addPress = true;
        //   userInput += '+';
        //   dotPress = false;
        // }
        if (outPut.isNotEmpty) {
          userInput = outPut + '+';
          outPut = '';
          subPress = true;
          previousOperator = '+';


        } else {
          if (userInput.isNotEmpty && '+-x÷'.contains(userInput[userInput.length - 1])) {
            // If the previous character is an operator, replace it with '-'
            userInput = userInput.substring(0, userInput.length - 1) + '+';
            previousOperator = '+';

          } else {
            if(userInput.isNotEmpty){
              userInput += '+';
            }

            previousOperator = '+';

          }
        }

        break;
      case 16:
        mulPress = false;
        userInput += '0';
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          userInput = '';
          outPut = '';
          userInput += '0';
        }

        break;
      case 17:
        if (!dotPress && userInput.isNotEmpty) {
          userInput += '.';
          dotPress = true;
        }
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          userInput = '';
          outPut = '';
          userInput += '0.';
        }

        break;
      case 18:

        print("object");
        break;

      default:
        hide = true;
        onPress(index);

        break;
    }
  }

  void onPress(value) {
    String replace = userInput;
    replace = userInput
        .replaceAll(
      'x',
      '*',
    )
        .replaceAll('÷', '/');

    Parser p = Parser();
    Expression exp = p.parse(replace);

    ContextModel contextModel = ContextModel();
    double evaluate = exp.evaluate(EvaluationType.REAL, contextModel);

    if (evaluate % 1 == 0) {
      outPut = evaluate.toInt().toString(); // Convert to int and then to string
    } else {
      outPut =
          evaluate.toStringAsFixed(2); // Limiting output to 2 decimal places
    }
    if (outPut.endsWith('.0')) {
      outPut = outPut.substring(0, outPut.length - 2);

      userInput = outPut;

      userInput = '';
      mulPress = true;
      dividePress = true;
      subPress = true;
      addPress = true;
    } else {}

    setState(() {});
  }
}
