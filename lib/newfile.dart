import 'package:math_expressions/math_expressions.dart';

class InputClass{



 static var userInput = '';
 static var outPut = '';


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
 static bool mulPress = true;
 static bool dotPress = false;
 static bool subPress = true;
 static bool addPress = true;
 static bool dividePress = true;
 static bool pPress = true;

 static  bool isDarkModeEnabled = false;
 static bool hide = false;
 static var outPutSize = 34.0;




 static void inputOutputClear() {
    userInput = '';
    outPut = '';
  }

 static void setOpFalse() {
    subPress = false;
    dividePress = false;
    mulPress = false;
    addPress = false;
  }

  String previousOperator = '';

  static void inputProcess({required int index,required String userInput, required String outPut,}) {
    switch (index) {
      case 0:
        inputOutputClear();

        addPress = true;
        subPress = true;
        dividePress = true;
        mulPress = true;
        dotPress = false;


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
        if (outPut.isNotEmpty) {
          double doubleValue = double.parse(outPut);
          doubleValue = doubleValue * 0.01;
          outPut = doubleValue.toString();

        } else if (userInput.isNotEmpty) {
          double doubleValue = double.parse(userInput);
          doubleValue = doubleValue * 0.01;
          outPut = doubleValue.toString();
          if (outPut.length > 5 && outPut.contains('.')) {
            outPut = outPut.substring(0, outPut.length - 13);


          } else {
            outPut = doubleValue.toString();
          }

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


        if (outPut.isNotEmpty && userInput.isNotEmpty) {
          inputOutputClear();

          userInput += '8';
        }

        break;
      case 6:
        setOpFalse();
        userInput += '9';


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

 static  void onEqualPress() {
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

    }


  }


}






