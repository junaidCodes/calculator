import 'package:math_expressions/math_expressions.dart';

class InputProcess{
  var userInput = '';
  var outPut = '';
  bool mulPress = false;

  bool dotPress = false;
  bool subPress = false;
  bool addPress = false;
  bool dividePress = false;

  bool isDarkModeEnabled = false;
  bool hide = false ;
  var outPutSize = 34.0;

  void inputProcess(int index){

    switch(index){
      case 0:
        userInput = '';
        outPut = '';
        dotPress = false;
        break;

      case 1:
        userInput = userInput.substring(0,userInput.length -1).toString();

        break;

      case 2:
        userInput = '';
        break;

      case 3:
        if(!dividePress){
          dividePress= true;
          userInput += '/';
          dotPress = false;
        }
        break;



      case 4:
        dividePress = false;
        subPress = false;
        addPress = false;
        mulPress = false;

        userInput += '7';


        break;

      case 5:
        dividePress = false;
        subPress = false;
        addPress = false;

        mulPress = false;
        userInput += '8';
        break;
      case 6:
        mulPress = false;
        dividePress = false;
        subPress = false;
        addPress = false;
        userInput += '9';
        break;
      case 7:

        if(!mulPress){
          mulPress= true;
          userInput += 'x';
          dotPress = false;
        }



        break;
      case 8:
        dividePress = false;
        subPress = false;
        addPress = false;
        mulPress = false;
        userInput += '4';
        break;
      case 9:
        dividePress = false;
        subPress = false;
        addPress = false;
        mulPress = false;
        userInput += '5';
        break;
      case 10:
        dividePress = false;
        subPress = false;
        addPress = false;
        mulPress = false;
        userInput += '6';
        break;
      case 11:
        if(!subPress){
          subPress= true;
          userInput += '-';
          dotPress = false;
        }
        dotPress = false;

        break;
      case 12:
        dividePress = false;
        subPress = false;
        addPress = false;
        mulPress = false;
        userInput += '1';
        break;
      case 13:
        dividePress = false;
        subPress = false;
        addPress = false;
        mulPress = false;
        userInput += '2';
        break;
      case 14:
        dividePress = false;
        subPress = false;
        addPress = false;
        mulPress = false;
        userInput += '3';
        break;
      case 15:
      // dotPress = false

        if(!addPress){
          addPress= true;
          userInput += '+';
          dotPress = false;
        }
        dotPress = false;



        break;
      case 16:
        mulPress = false;
        userInput += '0';

        break;
      case 17:

        if(!dotPress && userInput.isNotEmpty) {
          userInput += '.' ;
          dotPress  =true;
        }





        break;
      case 18:
        print("null") ;
        break;

      default:
        onPress();

        break ;

    }

  }


   onPress(){
    String replace = userInput;
    replace = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp= p.parse(replace);
    ContextModel contextModel = ContextModel();
    double evaluate = exp.evaluate(EvaluationType.VECTOR, contextModel);
    outPut = evaluate.toString();
    if(outPut.endsWith('.0')){
      outPut = outPut.substring(0,outPut.length - 2);
      userInput = outPut ;
      hide = true;

    }

  }
}

