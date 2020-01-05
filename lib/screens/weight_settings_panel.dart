import 'package:albus/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:albus/providers/weights.dart';

class WeightPanel extends StatefulWidget {
  @override
  _WeightPanelState createState() => _WeightPanelState();
}

class _WeightPanelState extends State<WeightPanel> with ChangeNotifier {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text('Enter Weight in KG'),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
              // controller: _controller,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (val) {
                if (_formKey.currentState.validate()) {
                  Navigator.pop(context);
                }
              },
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration:
                  textInputDecoration.copyWith(hintText: 'Weight in KG'),
              validator: (val) =>
                  int.tryParse(val) > 200 ? 'Enter a weight below 200' : null,
              onChanged: (val) {
                if (int.tryParse(val) < 200) {
                  setState(() => Provider.of<Weights>(context)
                      .changeWeight(int.tryParse(val)));
                }
              }),
          SizedBox(
            height: 20.0,
          ),
          FlatButton(
              child: Text('OK'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Navigator.pop(context);
                }
              }),
        ],
      ),
    );
  }
}
