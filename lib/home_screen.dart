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
  final FocusNode focusNode = FocusNode();

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
    "+-",
    "="
  ];
  bool mulPress = true;
  bool dotPress = false;
  bool subPress = true;
  bool addPress = true;
  bool dividePress = true;
  bool pPress = true;

  bool isDarkModeEnabled = false;
  bool hide = false;
  var outPutSize = 34.0;
  TextEditingController controller = TextEditingController();

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.text = outPut;
    setState(() {
      // onPress();
    });
  }

  @override
  Widget build(BuildContext context) {
    // themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light;
    // ),
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration:  BoxDecoration(
              // color: isDarkModeEnabled ? Colors.black : Colors.blue

              gradient:
              LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: isDarkModeEnabled
                    ? [
                        const Color(0xffe98a7f),
                        const Color(0xffe98a7f),
                      ]
                    : [
                        const Color(0xff2d3875).withOpacity(0.9),
                  const Color(0xff2d3875),

                      ],
              ),
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Switch(
                          value: isDarkModeEnabled,
                          onChanged: (value) {
                            setState(() {
                              isDarkModeEnabled = value;
                            });
                          }),
                    )),
                // TextFormField(
                //   cursorColor: Colors.white,
                //   showCursor: true
                //   ,
                //   onTap: (){
                //
                //     FocusScope.of(context).requestFocus(focusNode);
                //   },
                //   controller: _controller,
                //
                //   onChanged: (value) {
                //
                //     setState(() {
                //
                //       onPress();
                //     });
                //   },
                //   // initialValue: userInput.toString(),
                // ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10,top: 215),
                    child: Container(
                      height: 50,
                      child: Text(
                        userInput,
                        style: const TextStyle(fontSize: 30, color: Colors.white),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10,),
                    child: Container(
                      height: 70,
                      child: Text(
                        outPut,
                        style: const TextStyle(fontSize: 52, color: Colors.white),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),


                Expanded(


                  child: GridView.builder(
                    // padding:const EdgeInsets.only(top:242),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: false,
                      itemCount: 20,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 100,
                        mainAxisExtent: 70,
                        // crossAxisCount: 4,
                        // childAspectRatio: 1.01,

                      ),
                      itemBuilder: (BuildContext context, index) {
                        return GestureDetector(
                          onTap: () {
                            inputProcess(index);
                            // obj.inputProcess(index);

                            setState(() {});
                          },
                          child: Container(


                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(

                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: isDarkModeEnabled
                                    ? index == 19? [
                                  const Color(0xff283068),
                                  Colors.white,
                                ]: [
                                   Colors.white,
                                  Colors.white,
                                ]
                                    : index == 19 ? [
                                  const Color(0xff283068),
                                  Colors.white,
                                ] : [
                                  const Color(0xff283068),
                                  const Color(0xff283068),
                                ],
                              ),
                            ),
                            // color: Colors.green,
                            child: Center(
                                child: Text(
                              buttonText[index],
                              style:  TextStyle(
                                  color:isDarkModeEnabled ?  Colors.black.withOpacity(0.6) : Colors.white, fontSize: 40),
                            )),
                          ),
                        );
                        //
                      }),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  void inputOutputClear() {
    userInput = '';
    outPut = '';
  }

  void setOpFalse() {
    subPress = false;
    dividePress = false;
    mulPress = false;
    addPress = false;
  }

  String previousOperator = '';

  void inputProcess(int index) {
    switch (index) {
      case 0:
        inputOutputClear();

        addPress = true;
        subPress = true;
        dividePress = true;
        mulPress = true;
        dotPress = false;
        _controller.text = '';
        break;

      case 1:
        userInput = userInput.substring(0, userInput.length - 1).toString();
        setOpFalse();
        if (userInput.endsWith('.')) {
        } else {
          dotPress = false;
        }

        break;

      case 2:
        // double doubleValue = double.parse(userInput);
        // doubleValue = doubleValue * 0.01;
        //
        // outPut = doubleValue.toString();
        // // if (userInput.isNotEmpty) {
        // //   userInput += '%';
        // // }
        // // if(outPut.isNotEmpty){
        // //          log("Thissss");
        // //
        // //
        // // }
        // //
        // // else{
        // //    log("elseeeee");
        // // }
        // doubleValue = double.parse(outPut);
        // log("double value + $doubleValue");
        if (outPut.isNotEmpty) {
          double doubleValue = double.parse(outPut);
          doubleValue = doubleValue * 0.01;
          outPut = doubleValue.toString();
          _controller.text = outPut;

        } else if (userInput.isNotEmpty) {
          double doubleValue = double.parse(userInput);
          doubleValue = doubleValue * 0.01;
          outPut = doubleValue.toString();
          if(outPut.length > 5 && outPut.contains('.')){
            outPut = outPut.substring(0,outPut.length - 13);

            log("length is ${outPut.length.toString()}");
          }
          else {
            outPut = doubleValue.toString();

          }
          _controller.text = outPut;

        }



        break;

      case 3:
        dotPress = false;
        if (outPut.isNotEmpty) {
          userInput = '$outPut÷';
          outPut = '';
          dividePress = true;
          // previousOperator = '÷';
        } else {
          if (userInput.isNotEmpty &&
              '+-x÷'.contains(userInput[userInput.length - 1])) {
            // If the previous character is an operator, replace it with '-'
            userInput = '${userInput.substring(0, userInput.length - 1)}÷';
            // previousOperator = '÷';
          } else {
            if (userInput.isNotEmpty) {
              userInput += '÷';
            }
            // previousOperator = '÷';
          }
        }

        break;

      case 4:

        setOpFalse();

        userInput += '7';
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          inputOutputClear();
          userInput += '7';
        }

        break;

      case 5:
        setOpFalse();
        userInput += '8';
        _controller.text = userInput;

        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          inputOutputClear();

          userInput += '8';
        }

        break;
      case 6:
        setOpFalse();
        userInput += '9';
        _controller.text = userInput;

        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          inputOutputClear();

          userInput += '9';
        }
        break;
      case 7:
        // onPress();
        dotPress = false;

        if (outPut.isNotEmpty) {
          userInput = '${outPut}x';
          outPut = '';
          mulPress = true;
          // previousOperator = 'x';
        } else {
          if (userInput.isNotEmpty &&
              '+-x÷'.contains(userInput[userInput.length - 1])) {
            userInput = '${userInput.substring(0, userInput.length - 1)}x';
            // previousOperator = 'x';
          } else {
            if (userInput.isNotEmpty) {
              userInput += 'x';
            }
            // previousOperator = 'x';
          }
        }

        break;
      case 8:
        setOpFalse();
        userInput += '4';
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          inputOutputClear();

          userInput += '4';
        }
        break;
      case 9:
        setOpFalse();
        userInput += '5';
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          inputOutputClear();

          userInput += '5';
        }
        break;
      case 10:
        setOpFalse();
        userInput += '6';
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          inputOutputClear();

          userInput += '6';
        }
        break;
      case 11:
        dotPress = false;

        if (outPut.isNotEmpty) {
          userInput = '$outPut-';
          outPut = '';
          subPress = true;
          // previousOperator = '-';
        } else {
          if (userInput.isNotEmpty &&
              '+-x÷'.contains(userInput[userInput.length - 1])) {
            // If the previous character is an operator, replace it with '-'
            userInput = '${userInput.substring(0, userInput.length - 1)}-';
            // previousOperator = '-';
          } else {
            if (userInput.isNotEmpty) {
              userInput += '-';
            }
            // previousOperator = '-';
          }
        }
        break;
      case 12:
        setOpFalse();
        userInput += '1';

        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          inputOutputClear();

          userInput += '1';
        }
        break;
      case 13:
        setOpFalse();
        userInput += '2';
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          inputOutputClear();

          userInput += '2';
        }
        break;
      case 14:
        setOpFalse();
        userInput += '3';
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          inputOutputClear();

          userInput += '3';
        }

        break;
      case 15:
        dotPress = false;

        if (outPut.isNotEmpty) {
          userInput = '$outPut+';
          outPut = '';
          subPress = true;
        } else {
          if (userInput.isNotEmpty &&
              '+-x÷'.contains(userInput[userInput.length - 1])) {
            // If the previous character is an operator, replace it with '-'
            userInput = '${userInput.substring(0, userInput.length - 1)}+';
          } else {
            if (userInput.isNotEmpty) {
              userInput += '+';
            }
          }
        }

        break;
      case 16:
        mulPress = false;
        userInput += '0';
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          inputOutputClear();

          userInput += '0';
        }

        break;
      case 17:
        if (!dotPress && userInput.isNotEmpty) {
          log("this1");
          userInput += '.';
          dotPress = true;
        }
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          // dotPress = false;

          inputOutputClear();

          userInput += '0.';
        }
        if (userInput.isNotEmpty &&
            '+-x÷'.contains(userInput[userInput.length - 1])) {
          dotPress = true;

          // If the previous character is an operator, replace it with '-'
          // userInput = '${userInput.substring(0, userInput.length - 1)}.';
          userInput += '.';
        }

        break;
      case 18:
        if (outPut.isNotEmpty) {
          double a = double.parse(outPut);
          a = -1.0 * a;

          outPut = a.toString();
        }
        // print("object");
        break;

      default:
        hide = true;
        onEqualPress();
        // _controller.text = outPut;

        break;
    }
  }

  void onEqualPress() {
    String replace = userInput;
    replace = userInput
        .replaceAll(
          'x',
          '*',
        )
        .replaceAll('÷', '/');

    debugPrint("userInput $userInput");

    try {
      RegExp regex = RegExp(r"[+\-*/]$");
      if (regex.hasMatch(replace)) {
        replace = replace.substring(0, replace.length - 1);
      }
      debugPrint("replace $replace");

      Parser p = Parser();
      Expression exp = p.parse(replace);
      debugPrint("exp $exp");

      ContextModel contextModel = ContextModel();
      double evaluate = exp.evaluate(EvaluationType.REAL, contextModel);

      if (evaluate % 1 == 0) {
        outPut =
            evaluate.toInt().toString(); // Convert to int and then to string
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
    } catch (e) {
      debugPrint("exception $e");
    }

    setState(() {});
  }
}
