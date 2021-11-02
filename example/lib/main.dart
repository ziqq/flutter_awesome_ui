import 'package:flutter/material.dart';
import 'package:flutter_awesome_ui/flutter_awesome_ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Input',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.deepPurple,
          disabledColor: Color(0xFFEEF0F2),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            bodyText1: TextStyle(
              height: 1.45,
              fontSize: 17,
              letterSpacing: 0,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
            ),
            bodyText2: TextStyle(
              fontSize: 16,
              letterSpacing: 0,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
            ),
          )),
      home: AwesomeInputView(),
    );
  }
}

class AwesomeInputView extends StatefulWidget {
  @override
  _AwesomeInputViewState createState() => _AwesomeInputViewState();
}

class _AwesomeInputViewState extends State<AwesomeInputView> {
  final _inputController = TextEditingController();
  final _selectController = TextEditingController();

  final _selectItems = List.generate(
      3, (i) => AwesomeSelectItem(text: 'Item ${i + 1}', value: i + 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Awesome UI'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('inputController: ${_inputController.text}'),
            // SizedBox(height: 8),
            AwesomeInput(
              labelText: 'Awesome Input with controller',
              controller: _inputController,
              textInputAction: TextInputAction.done,
            ),
            // Text('selectControllerText: ${_selectController.text}'),
            // SizedBox(height: 8),
            AwesomeSelect(
              labelText: 'Awesome Select with controller',
              controller: _selectController,
              items: _selectItems,
            ),
            AwesomeInput(
              labelText: 'Awesome Input with helper text',
              helperText: 'Example helper text',
              textInputAction: TextInputAction.done,
            ),
            AwesomeInput(
              labelText: 'Awesome Input with initial value & disabled',
              initialValue: 'Example initial value',
              enabled: false,
            ),
            AwesomeInput(
              labelText: 'Awesome Input with error text',
              initialValue: 'Example initial value',
              errorText: 'Example error text',
              textInputAction: TextInputAction.done,
            ),
            AwesomeSelect(
              labelText: 'Awesome select example',
              items: _selectItems,
              initialValue: 1,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                AwesomeCheckBoxRounded(
                  size: 40,
                  onTap: (bool? value) {},
                ),
                SizedBox(width: 20),
                AwesomeCheckBoxRounded(
                  size: 40,
                  onTap: (bool? value) {},
                ),
                SizedBox(width: 20),
                AwesomeCheckBoxRounded(
                  size: 40,
                  isChecked: true,
                  onTap: (bool? value) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
