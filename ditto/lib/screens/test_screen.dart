import 'package:ditto/bloc/test_bloc.dart';
import 'package:ditto/helper/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  TestBloc _testBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _testBloc = Provider.of<TestBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text("Logic Gates Test"),
        ),
      ),
      body: Center(
        child: Container(
          width: Utils.getDesignHeight(800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<int>(
                stream: _testBloc.questionOneStream,
                builder: (context, snapshot) {
                  return _questionAndAnswer(
                    question: '1. What is Inheritance?',
                    answerOne: 'nothing but assigning behavior or value in a subclass to something that was already declared in the main class',
                    answerTwo: 'concept where one class shares the structure and behavior defined in another class.*',
                    answerVal: snapshot.data,
                    sink: _testBloc.questionOneSink,
                  );
                }
              ),
              StreamBuilder<int>(
                  stream: _testBloc.questionTwoStream,
                builder: (context, snapshot) {
                  return _questionAndAnswer(
                    question: '2. What is an abstract class?',
                    answerOne: 'class which cannot be instantiated*',
                    answerTwo: ' an instance of a class',
                    answerVal: snapshot.data,
                    sink: _testBloc.questionTwoSink,
                  );
                }
              ),
              StreamBuilder<int>(
                  stream: _testBloc.questionThreeStream,
                builder: (context, snapshot) {
                  return _questionAndAnswer(
                    question: '3. What is abstraction?',
                    answerOne: 'shows only the necessary details to the client of an object.*',
                    answerTwo: 'simply a representation of a type of object.',
                    answerVal: snapshot.data,
                    sink: _testBloc.questionThreeSink,
                  );
                }
              ),
              StreamBuilder<int>(
                  stream: _testBloc.questionFourStream,
                builder: (context, snapshot) {
                  return _questionAndAnswer(
                    question: '4. What is Polymorphism?',
                    answerOne: 'concept where one class shares the structure and behavior defined in another class.',
                    answerTwo: ' nothing but assigning behavior or value in a subclass to something that was already declared in the main class.*',
                    answerVal: snapshot.data,
                    sink: _testBloc.questionFourSink,
                  );
                }
              ),
              StreamBuilder<int>(
                  stream: _testBloc.questionFiveStream,
                builder: (context, snapshot) {
                  return _questionAndAnswer(
                    question: '5. What is an interface?',
                    answerOne: 'collection of an abstract method.*',
                    answerTwo: 'it shows only the necessary details to the client of an object.',
                    answerVal: snapshot.data,
                    sink: _testBloc.questionFiveSink,
                  );
                }
              ),
              Container(
                height: Utils.getDesignHeight(40),
                width: Utils.getDesignWidth(100),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => _testBloc.savePoint(),
                  child: Text(
                    "Submit Answers",
                    style: Theme.of(context).primaryTextTheme.button.copyWith(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _questionAndAnswer({String question, String answerOne, String answerTwo, int answerVal, Sink<int> sink}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15.0),
          child: Text(
            question,
            style: Theme.of(context).primaryTextTheme.button.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              RadioListTile(
                title: Text(answerOne),
                value: 1,
                groupValue: answerVal,
                onChanged: (value) => sink.add(value),
              ),
              RadioListTile(
                title: Text(answerTwo),
                value: 2,
                groupValue: answerVal,
                onChanged: (value) => sink.add(value),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
