import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_awesome_ui/flutter_awesome_ui.dart';

import 'package:example/ui/platforms/platforms_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _inputController = TextEditingController();
  final _selectController = TextEditingController();

  final _selectItems = List.generate(
      3, (i) => AwesomeSelectItem(text: 'Item ${i + 1}', value: i + 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AwesomeUiCupertinoLayout(
        title: 'Home Page',
        contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        leading: CupertinoButton(
          minSize: 10,
          padding: EdgeInsets.zero,
          child: Text(
            'Edit',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          onPressed: () {},
        ),
        trailing: CupertinoButton(
          minSize: 10,
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PlatformsView()),
            );
          },
          child: Icon(
            Icons.search_rounded,
            size: 24,
            color: Theme.of(context).textTheme.bodyText2?.color,
          ),
        ),
        body: [
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

          SizedBox(height: 200),
          SizedBox(height: 200),
        ],
      ),
    );
  }
}
