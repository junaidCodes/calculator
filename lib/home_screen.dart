import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorHomeScreen extends StatefulWidget {
  const CalculatorHomeScreen({super.key});

  @override
  State<CalculatorHomeScreen> createState() => _CalculatorHomeScreenState();
}

class _CalculatorHomeScreenState extends State<CalculatorHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollToEnd();
  }

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
  bool cursor = true;
  bool zeroPress = false;
  bool isDarkModeEnabled = false;
  bool hide = false;
  bool ePress = false;
  double outPutSize = 52;
  double inputSize = 35;

  TextEditingController controller = TextEditingController();
  TextEditingController Empcontroller = TextEditingController();

  final TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  void scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            scrollPhysics: AlwaysScrollableScrollPhysics(),
                            scrollController: _scrollController,
                            readOnly: true,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.white, fontSize: inputSize),
                            cursorColor: Colors.white,
                            showCursor: cursor,
                            onTap: () {},
                            controller:
                                hide == false ? _controller : Empcontroller,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            autofocus: true,
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: SizedBox(
                              height: 70,
                              child: Text(
                                outPut,
                                style: TextStyle(
                                    fontSize: outPutSize, color: Colors.white),
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

  String percentageOP = '';

  String previousOperator = '';

  void inputProcess(int index) {
    hide = false;
    cursor = true;

    int cursorPos = _controller.selection.baseOffset;
    if (cursorPos == -1) cursorPos = userInput.length;

    switch (index) {
      case 0: // AC

        outPutSize = 52;
        inputOutputClear();
        ePress = false;
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
        onPercentagePress();
        break;

        break;

      case 3: // ÷÷÷
        operatorPress('÷');

        break;

      case 4: // 7
        operandPress('7');
        break;

      case 5: // 8
        operandPress('8');
        break;
      case 6: // 9
        operandPress('9');

        break;
      case 7: // x
        operatorPress('x');

        break;

      case 8: // 4
        operandPress('4');

        break;

      case 9: // 5
        operandPress('5');

        break;
      case 10: //  6
        operandPress('6');

        break;
      case 11: // -
        operatorPress('-');

        break;

      case 12: // 1
        operandPress('1');

        break;
      case 13: // 2
        operandPress('2');

        break;
      case 14: // 3
        operandPress('3');

        break;
      case 15: // +
        operatorPress('+');

        break;

      case 16: // 0
        onZeroPress();
        break;

      case 17: // .
        onDotPress();

        break;

      case 18: // +-

        plusMines();

        break;
      default: // =

        hide = true;
        onEqualPress();
        ePress = true;
        outPutSize = 60;

        cursor = false;
        break;
    }
  }

  void operandPress(String operand) {

    if(userInput.contains('.')  && userInput.length >3){}
    else {
    outPutSize = 52;
    hide = false;
    int cursorPos = _controller.selection.baseOffset;
    if (cursorPos == -1) cursorPos = userInput.length;

    setOpFalse();

    if (outPut.isNotEmpty && userInput.isNotEmpty && ePress == true) {
      inputOutputClear();
      _controller.text = '';
      _controller.text = operand;
      userInput += operand;
      ePress = false;
    } else {
      userInput =
          '${userInput.substring(0, cursorPos)}$operand${userInput.substring(cursorPos)}';
      cursorPos++;
      _controller.text = userInput;
      _controller.selection =
          TextSelection.fromPosition(TextPosition(offset: cursorPos));
    }

    if (userInput.contains('+') ||
        userInput.contains('-') ||
        userInput.contains('x') ||
        userInput.contains('÷')) {
      onEqualPress();
    }}
    scrollToEnd();
  }

  void operatorPress(String op) {
    outPutSize = 52;
    hide = false;
    int cursorPos = _controller.selection.baseOffset;
    if (cursorPos == -1) cursorPos = userInput.length;

    dotPress = false;

    {
      if (ePress == true && outPut.isNotEmpty) {
        userInput = outPut + op;
        _controller.text = userInput;
        cursorPos = userInput.length;
        ePress = false;
      } else if (userInput.isNotEmpty) {
        if (cursorPos > 0 && !'+-x÷'.contains(userInput[cursorPos - 1])) {
          userInput =
              '${userInput.substring(0, cursorPos)}$op${userInput.substring(cursorPos)}'; //
          cursorPos += op.length;
        } else if (cursorPos == 0) {
          userInput = '$op$userInput';
          cursorPos = op.length;
        } else if (cursorPos > 0 && '+-x÷'.contains(userInput[cursorPos - 1])) {
          userInput =
              '${userInput.substring(0, cursorPos - 1)}$op${userInput.substring(cursorPos)}';
          cursorPos = cursorPos; // cursorPos remains the same
        }
      } else {
        userInput = op;
        cursorPos = op.length;
      }
    }

    _controller.text = userInput;
    _controller.selection =
        TextSelection.fromPosition(TextPosition(offset: cursorPos));
    scrollToEnd();
    onEqualPress();
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

  onPercentagePress() {
    if (outPut.isNotEmpty) {
      try {
        double doubleValue = double.parse(outPut);
        doubleValue = doubleValue * 0.01;

        percentageOP = doubleValue.toString();
        _controller.text = '$percentageOP%';
        outPut = percentageOP;
        userInput = outPut;
      } catch (e) {
        log("Error: Invalid output");
      }
    }
    if (userInput.isNotEmpty) {
      try {
        int lastPercentIndex = userInput.lastIndexOf('%');
        if (lastPercentIndex != -1) {
          String beforePercent = userInput.substring(0, lastPercentIndex);
          String percentValue = userInput.substring(lastPercentIndex + 1);

          Parser p = Parser();
          Expression exp =
              p.parse(beforePercent.replaceAll('×', '*').replaceAll('÷', '/'));
          ContextModel cm = ContextModel();
          double result = exp.evaluate(EvaluationType.REAL, cm);

          double percentage = double.parse(percentValue) * 0.01;

          double finalResult = result * percentage;

          userInput = finalResult.toString();
          _controller.text = userInput + '%';
        } else {
          double doubleValue = double.parse(userInput);
          doubleValue = doubleValue * 0.01;

          userInput = doubleValue.toString();
          outPut = userInput;
          _controller.text = userInput + '%';
        }
      } catch (e) {
        log("Error: Invalid input");
      }
    }
  }

  onZeroPress() {
    int cursorPos = _controller.selection.baseOffset;
    if (cursorPos == -1) cursorPos = userInput.length;

    setOpFalse();

    if (_controller.text.isEmpty || _controller.text == '0') {
      userInput = '0';
      cursorPos = 1;
      _controller.text = userInput;
      _controller.selection =
          TextSelection.fromPosition(TextPosition(offset: cursorPos));
    } else {
      userInput =
          '${userInput.substring(0, cursorPos)}0${userInput.substring(cursorPos)}';
      cursorPos++;
      _controller.text = userInput;
      _controller.selection =
          TextSelection.fromPosition(TextPosition(offset: cursorPos));
    }

    if (outPut.isNotEmpty && userInput.isNotEmpty && ePress == true) {
      inputOutputClear();
      userInput = '0';
      cursorPos = 1;
      _controller.text = userInput;
      _controller.selection =
          TextSelection.fromPosition(TextPosition(offset: cursorPos));
    }
    if (userInput.contains('+') ||
        userInput.contains('-') ||
        userInput.contains('x') ||
        userInput.contains('÷')) {
      onEqualPress();
    }
  }

  onDotPress() {
    int cursorPos = _controller.selection.baseOffset;
    if (cursorPos == -1) cursorPos = userInput.length;

    if (!dotPress && cursorPos > 0) {
      String beforeCursor = userInput.substring(0, cursorPos);

      String afterCursor = userInput.substring(cursorPos);

      bool dotExists =
          beforeCursor.split(RegExp(r'[\+\-\x÷]')).last.contains('.');

      if (!dotExists) {
        userInput = beforeCursor + '.' + afterCursor;
        cursorPos++;
        dotPress = true;
      }
    } else if (!dotPress && cursorPos == 0) {
      userInput = '0.' + userInput;
      cursorPos += 2;
      dotPress = true;
    }

    _controller.text = userInput;
    _controller.selection =
        TextSelection.fromPosition(TextPosition(offset: cursorPos));
    if (userInput.contains('+') ||
        userInput.contains('-') ||
        userInput.contains('x') ||
        userInput.contains('÷')) {
      onEqualPress();
    }
  }

  plusMines() {
    if (userInput.isNotEmpty) {
      double a;
      try {
        Parser p = Parser();
        Expression exp =
            p.parse(userInput.replaceAll('×', '*').replaceAll('÷', '/'));
        ContextModel cm = ContextModel();
        a = exp.evaluate(EvaluationType.REAL, cm);

        a = -1.0 * a;
        userInput = a.toString();

        log(a.toString());
      } catch (e) {
        log("Error: Invalid input");
      }
    }

    if (outPut.isNotEmpty) {
      try {
        double b = double.parse(outPut);
        b = -1.0 * b;
        outPut = b.toString();
      } catch (e) {
        log("Error");
      }
    }

    _controller.text = userInput;
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
      debugPrint("exp $exp");

      ContextModel contextModel = ContextModel();
      double evaluate = exp.evaluate(EvaluationType.REAL, contextModel);

      if (evaluate % 1 == 0) {
        outPut = evaluate.toInt().toString();
      } else {
        outPut = evaluate.toStringAsFixed(2);
      }
      if (outPut.endsWith('.0')) {
        outPut = outPut.substring(0, outPut.length - 2);

        userInput = outPut;

        userInput = '';
      } else {}
    } on Exception catch (e) {
      outPut = 'Error';
    }
  }
}
