import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorHomeScreen extends StatefulWidget {
  const CalculatorHomeScreen({super.key});

  @override
  State<CalculatorHomeScreen> createState() => _CalculatorHomeScreenState();
}

class _CalculatorHomeScreenState extends State<CalculatorHomeScreen> {
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
  bool eqPress = true;
  bool cursor = true;

  bool isDarkModeEnabled = false;
  bool hide = false;
  var outPutSize = 34.0;
  TextEditingController controller = TextEditingController();
  final TextEditingController _controller = TextEditingController();

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
            decoration: BoxDecoration(
              // color: isDarkModeEnabled ? Colors.red : Colors.blue,
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: !isDarkModeEnabled
                    ? [
                        const Color(0xffe98a7f),
                        const Color(0xffe98a7f),
                      ]
                    : [
                        Colors.blueAccent,
                        const Color(0xff2d3875),
                      ],
              ),
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            readOnly: true,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30),
                            cursorColor: Colors.white,
                            showCursor: cursor,
                            onTap: () {
                              // FocusScope.of(context).requestFocus(focusNode);
                            },
                            controller: _controller,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            autofocus: true,
                          ),
                          // Align(
                          //   alignment: Alignment.bottomRight,
                          //   child: Padding(
                          //     padding:
                          //     const EdgeInsets.only(right: 10, top: 150),
                          //     child: SizedBox(
                          //       height: 50,
                          //       child: Text(
                          //         userInput,
                          //         style: const TextStyle(
                          //             fontSize: 30, color: Colors.white),
                          //         textAlign: TextAlign.right,
                          //         overflow: TextOverflow.clip,
                          //         maxLines: 1,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: SizedBox(
                              height: 70,
                              child: Text(
                                outPut,
                                style: const TextStyle(
                                    fontSize: 52, color: Colors.white),
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                          left: 0,
                          top: 0,
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
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: false,
                      itemCount: 20,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 100,
                        mainAxisExtent: 72,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          onTap: () {
                            inputProcess(index);

                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              // border:
                              // Border.all(color: Colors.green, width: 1),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: !isDarkModeEnabled
                                    ? index == 19
                                        ? [
                                            Colors.transparent,
                                            Colors.transparent,
                                          ]
                                        : [
                                            Colors.white,
                                            Colors.white,
                                          ]
                                    : index == 19
                                        ? [
                                            Colors.transparent,
                                            Colors.transparent,
                                          ]
                                        : [
                                            const Color(0xff283060),
                                            const Color(0xff283068),
                                          ],
                              ),
                            ),
                            // color: Colors.green,
                            child: Center(
                                child: Text(
                              buttonText[index],
                              style: TextStyle(
                                  color: !isDarkModeEnabled
                                      ? index == 19
                                          ? Colors.white
                                          : Colors.black.withOpacity(0.6)
                                      : Colors.white,
                                  fontSize: 40),
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
    int cursorPos = _controller.selection.baseOffset;
    if (cursorPos == -1) cursorPos = userInput.length;
    cursor = true;

    switch (index) {
      case 0: // AC
        inputOutputClear();

        addPress = true;
        subPress = true;
        dividePress = true;
        mulPress = true;
        dotPress = false;
        _controller.text = '';
        break;

      case 1: // C
        dotPress = false;
        if (cursorPos > 0) {
          userInput = userInput.substring(0, cursorPos - 1) +
              userInput.substring(cursorPos);
          cursorPos--;
        }

        _controller.text = userInput;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos));

        setOpFalse();

        break;

      case 2: // %
        if (outPut.isNotEmpty) {
          double doubleValue = double.parse(outPut);
          doubleValue = doubleValue * 0.01;
          outPut = doubleValue.toString();
          _controller.text = outPut;
        } else if (userInput.isNotEmpty) {
          double doubleValue = double.parse(userInput);
          doubleValue = doubleValue * 0.01;
          outPut = doubleValue.toString();
          if (outPut.length > 5 && outPut.contains('.')) {
            outPut = outPut.substring(0, outPut.length - 13);

            log("length is ${outPut.length.toString()}");
          } else {
            outPut = doubleValue.toString();
          }
          _controller.text = outPut;
        }

        break;

      case 3: // ÷÷÷÷
        dotPress = false;
        if (outPut.isNotEmpty) {
          if (userInput.endsWith('÷')) {
          } else {
            userInput =
                '${userInput.substring(0, cursorPos)}÷${userInput.substring(cursorPos)}';
            cursorPos++;
          }

          addPress = true;
        } else {
          if (userInput.isNotEmpty) {
            // Check if the cursor is at the beginning or if an operator already exists at the cursor position
            if (cursorPos > 0 && !'+-x÷'.contains(userInput[cursorPos - 1])) {
              // Insert the divide operator at the cursor position
              userInput =
                  '${userInput.substring(0, cursorPos)}÷${userInput.substring(cursorPos)}';
              cursorPos++;
            } else if (cursorPos == 0) {
              // If the cursor is at the beginning, insert the operator
              userInput = '÷$userInput';
              cursorPos++;
            } else if (cursorPos > 0 &&
                '+-x÷'.contains(userInput[cursorPos - 1])) {
              // Replace the existing operator if there's already one at the cursor position
              userInput =
                  '${userInput.substring(0, cursorPos - 1)}÷${userInput.substring(cursorPos)}';
            }
          }
        }

        _controller.text = userInput;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos));
        break;

      case 4: // 7

        setOpFalse();
        userInput =
            '${userInput.substring(0, cursorPos)}7${userInput.substring(cursorPos)}';
        cursorPos++;
        _controller.text = userInput;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos));
        if (outPut.isNotEmpty && userInput.isNotEmpty && !eqPress) {
          inputOutputClear();
          _controller.text = '';
          _controller.text = '7';
          userInput += '7';
          eqPress = true;
        } else {}
        if (userInput.contains('+') ||
            userInput.contains('-') ||
            userInput.contains('x') ||
            userInput.contains('÷')) {
          onEqualPress();
        }

        break;

      case 5: // 8

        setOpFalse();
        userInput =
            '${userInput.substring(0, cursorPos)}8${userInput.substring(cursorPos)}';
        cursorPos++;
        _controller.text = userInput;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos));
        if (outPut.isNotEmpty && userInput.isNotEmpty && !eqPress) {
          inputOutputClear();
          _controller.text = '';
          _controller.text = '8';
          userInput += '8';
          eqPress = true;
        } else {}
        if (userInput.contains('+') ||
            userInput.contains('-') ||
            userInput.contains('x') ||
            userInput.contains('÷')) {
          onEqualPress();
        }
        break;
      case 6: // 9

        setOpFalse();
        userInput =
            '${userInput.substring(0, cursorPos)}9${userInput.substring(cursorPos)}';
        cursorPos++;
        _controller.text = userInput;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos));
        if (outPut.isNotEmpty && userInput.isNotEmpty && !eqPress) {
          inputOutputClear();
          _controller.text = '';
          _controller.text = '9';
          userInput += '9';
          eqPress = true;
        } else {}
        if (userInput.contains('+') ||
            userInput.contains('-') ||
            userInput.contains('x') ||
            userInput.contains('÷')) {
          onEqualPress();
        }
        break;
      case 7: // X
        dotPress = false;
        if (outPut.isNotEmpty) {
          if (userInput.endsWith('x')) {
          } else {
            userInput =
                '${userInput.substring(0, cursorPos)}x${userInput.substring(cursorPos)}';
            cursorPos++;
          }

          addPress = true;
        } else {
          if (userInput.isNotEmpty) {
            // Check if the cursor is at the beginning or if an operator already exists at the cursor position
            if (cursorPos > 0 && !'+-x÷'.contains(userInput[cursorPos - 1])) {
              // Insert the divide operator at the cursor position
              userInput =
                  '${userInput.substring(0, cursorPos)}x${userInput.substring(cursorPos)}';
              cursorPos++;
            } else if (cursorPos == 0) {
              // If the cursor is at the beginning, insert the operator
              userInput = 'x$userInput';
              cursorPos++;
            } else if (cursorPos > 0 &&
                '+-x÷'.contains(userInput[cursorPos - 1])) {
              // Replace the existing operator if there's already one at the cursor position
              userInput =
                  '${userInput.substring(0, cursorPos - 1)}x${userInput.substring(cursorPos)}';
            }
          }
        }

        _controller.text = userInput;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos));
        break;

      case 8: // 4

        setOpFalse();
        userInput =
            '${userInput.substring(0, cursorPos)}4${userInput.substring(cursorPos)}';
        cursorPos++;
        _controller.text = userInput;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos));
        if (outPut.isNotEmpty && userInput.isNotEmpty && !eqPress) {
          inputOutputClear();
          _controller.text = '';
          _controller.text = '4';
          userInput += '4';
          eqPress = true;
        } else {}
        if (userInput.contains('+') ||
            userInput.contains('-') ||
            userInput.contains('x') ||
            userInput.contains('÷')) {
          onEqualPress();
        }
        break;
      case 9: //5
        // setOpFalse();
        // userInput =
        // '${userInput.substring(0, cursorPos)}5${userInput.substring(cursorPos)}';
        // cursorPos++;
        // _controller.text = userInput;
        // _controller.selection =
        //     TextSelection.fromPosition(TextPosition(offset: cursorPos));
        // if (outPut.isNotEmpty && userInput.isNotEmpty) {
        //   inputOutputClear();
        //   _controller.text = '';
        //   _controller.text = '5';
        //   userInput += '5';
        // }
        // if(userInput.contains('+') || userInput.contains('-') ||userInput.contains('x') || userInput.contains('÷') ){
        //
        //   onEqualPress();
        // }

        setOpFalse();
        userInput =
            '${userInput.substring(0, cursorPos)}5${userInput.substring(cursorPos)}';
        cursorPos++;
        _controller.text = userInput;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos));
        if (outPut.isNotEmpty && userInput.isNotEmpty && !eqPress) {
          inputOutputClear();
          _controller.text = '';
          _controller.text = '5';
          userInput += '5';
          eqPress = true;
        } else {}
        if (userInput.contains('+') ||
            userInput.contains('-') ||
            userInput.contains('x') ||
            userInput.contains('÷')) {
          onEqualPress();
        }
        break;
      case 10: //6
        // setOpFalse();
        // userInput =
        // '${userInput.substring(0, cursorPos)}6${userInput.substring(cursorPos)}';
        // cursorPos++;
        // _controller.text = userInput;
        // _controller.selection =
        //     TextSelection.fromPosition(TextPosition(offset: cursorPos));
        // if (outPut.isNotEmpty && userInput.isNotEmpty) {
        //   inputOutputClear();
        //   _controller.text = '';
        //   _controller.text = '6';
        //   userInput += '6';
        // }
        // if(userInput.contains('+') || userInput.contains('-') ||userInput.contains('x') || userInput.contains('÷') ){
        //
        //   onEqualPress();
        // }

        setOpFalse();
        userInput =
            '${userInput.substring(0, cursorPos)}6${userInput.substring(cursorPos)}';
        cursorPos++;
        _controller.text = userInput;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos));
        if (outPut.isNotEmpty && userInput.isNotEmpty && !eqPress) {
          inputOutputClear();
          _controller.text = '';
          _controller.text = '6';
          userInput += '6';
          eqPress = true;
        } else {}
        if (userInput.contains('+') ||
            userInput.contains('-') ||
            userInput.contains('x') ||
            userInput.contains('÷')) {
          onEqualPress();
        }
        break;
      case 11: //-
        dotPress = false;
        if (outPut.isNotEmpty) {
          // userInput = '$outPut-';
          // outPut = '';
          if (userInput.endsWith('-')) {
          } else {
            userInput =
                '${userInput.substring(0, cursorPos)}-${userInput.substring(cursorPos)}';
            cursorPos++;
          }

          addPress = true;
        } else {
          if (userInput.isNotEmpty) {
            // Check if the cursor is at the beginning or if an operator already exists at the cursor position
            if (cursorPos > 0 && !'+-x÷'.contains(userInput[cursorPos - 1])) {
              // Insert the divide operator at the cursor position
              userInput =
                  '${userInput.substring(0, cursorPos)}-${userInput.substring(cursorPos)}';
              cursorPos++;
            } else if (cursorPos == 0) {
              // If the cursor is at the beginning, insert the operator
              userInput = '-$userInput';
              cursorPos++;
            } else if (cursorPos > 0 &&
                '+-x÷'.contains(userInput[cursorPos - 1])) {
              // Replace the existing operator if there's already one at the cursor position
              userInput =
                  '${userInput.substring(0, cursorPos - 1)}-${userInput.substring(cursorPos)}';
            }
          }
        }

        _controller.text = userInput;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos));
        break;

      case 12: // 1
        setOpFalse();
        userInput =
            '${userInput.substring(0, cursorPos)}1${userInput.substring(cursorPos)}';
        cursorPos++;
        _controller.text = userInput;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos));
        if (outPut.isNotEmpty && userInput.isNotEmpty && !eqPress) {
          inputOutputClear();
          _controller.text = '';
          _controller.text = '1';
          userInput += '1';
          eqPress = true;
        } else {}
        if (userInput.contains('+') ||
            userInput.contains('-') ||
            userInput.contains('x') ||
            userInput.contains('÷')) {
          onEqualPress();
        }
        break;

      case 13: //2

        setOpFalse();
        userInput =
            '${userInput.substring(0, cursorPos)}2${userInput.substring(cursorPos)}';
        cursorPos++;
        _controller.text = userInput;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos));
        if (outPut.isNotEmpty && userInput.isNotEmpty && !eqPress) {
          inputOutputClear();
          _controller.text = '';
          _controller.text = '2';
          userInput += '2';
          eqPress = true;
        } else {}
        if (userInput.contains('+') ||
            userInput.contains('-') ||
            userInput.contains('x') ||
            userInput.contains('÷')) {
          onEqualPress();
        }

        break;
      case 14: //3

        setOpFalse();
        userInput =
            '${userInput.substring(0, cursorPos)}3${userInput.substring(cursorPos)}';
        cursorPos++;
        _controller.text = userInput;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos));
        if (outPut.isNotEmpty && userInput.isNotEmpty && !eqPress) {
          inputOutputClear();
          _controller.text = '';
          _controller.text = '3';
          userInput += '3';
          eqPress = true;
        } else {}
        if (userInput.contains('+') ||
            userInput.contains('-') ||
            userInput.contains('x') ||
            userInput.contains('÷')) {
          onEqualPress();
        }
        break;
      case 15: //+
        dotPress = false;
        if (outPut.isNotEmpty) {
          // userInput = '$outPut+';
          // userInput = '$userInput+';
     // cursorPos++ ;
     //      outPut = '';

          if (userInput.endsWith('+')) {
          } else {
            userInput =
                '${userInput.substring(0, cursorPos)}+${userInput.substring(cursorPos)}';
            cursorPos++;
          }

          addPress = true;
        } else {
          if (userInput.isNotEmpty) {
            // Check if the cursor is at the beginning or if an operator already exists at the cursor position
            if (cursorPos > 0 && !'+-x÷'.contains(userInput[cursorPos - 1])) {
              // Insert the divide operator at the cursor position
              userInput =
                  '${userInput.substring(0, cursorPos)}+${userInput.substring(cursorPos)}';
              cursorPos++;
            } else if (cursorPos == 0) {
              // If the cursor is at the beginning, insert the operator
              userInput = '+$userInput';
              cursorPos++;
            } else if (cursorPos > 0 &&
                '+-x÷'.contains(userInput[cursorPos - 1])) {
              // Replace the existing operator if there's already one at the cursor position
              userInput =
                  '${userInput.substring(0, cursorPos - 1)}+${userInput.substring(cursorPos)}';
            }
          }
        }

        _controller.text = userInput;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos));
        break;

      case 16: // 0
        setOpFalse();
        userInput =
            '${userInput.substring(0, cursorPos)}0${userInput.substring(cursorPos)}';
        cursorPos++;
        _controller.text = userInput;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos));
        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          inputOutputClear();
          _controller.text = '';
          _controller.text = '0';
          userInput += '0';
        }

        break;

      case 17: // .
        // Check if dotPress is false and cursor is not at the start
        if (!dotPress && cursorPos > 0) {
          // Get the part of the userInput before the cursor
          String beforeCursor = userInput.substring(0, cursorPos);
          // Get the part of the userInput after the cursor
          String afterCursor = userInput.substring(cursorPos);

          // Check if there's already a dot in the current number segment
          bool dotExists =
              beforeCursor.split(RegExp(r'[\+\-\x÷]')).last.contains('.');

          // Only insert dot if there's no existing dot in the current number
          if (!dotExists) {
            userInput = beforeCursor + '.' + afterCursor;
            cursorPos++;
            dotPress = true;
          }
        } else if (!dotPress && cursorPos == 0) {
          // If the cursor is at the start, allow inserting a leading zero with dot
          userInput = '0.' + userInput;
          cursorPos += 2; // Move cursor after the inserted '0.'
          dotPress = true;
        }

        _controller.text = userInput;
        _controller.selection =
            TextSelection.fromPosition(TextPosition(offset: cursorPos));

        break;

      case 18: // +-
        if (outPut.isNotEmpty) {
          double a = double.parse(outPut);
          a = -1.0 * a;

          outPut = a.toString();
        }

        _controller.text = userInput;

        break;

      default: // =
        eqPress = false;
        hide = true;
        onEqualPress();
        _controller.text = outPut;
        userInput = '' ;
        _controller.text = '';
        // cursor = false;

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

    try {
      RegExp regex = RegExp(r"[+\-*/]$");
      if (regex.hasMatch(replace)) {
        replace = replace.substring(0, replace.length - 1);
      }

      Parser p = Parser();
      Expression exp = p.parse(replace);

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
  }
}
