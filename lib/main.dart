import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController hieghtController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = "";
    hieghtController.text = "";
    setState(() {
      _infoText = "Informe seus dados";

      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse( weightController.text );
      double hieght = double.parse( hieghtController.text ) / 100;
      double imc = weight / (hieght * hieght);

      if( imc < 18.6 ) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if ( imc <= 18.6 && imc <= 29.9 ) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if ( imc >= 30) {
        _infoText = "Obeso (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120, color: Colors.redAccent),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso em kgm",
                    labelStyle: TextStyle(color: Colors.redAccent)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.redAccent, fontSize: 25),
                controller: weightController,
                validator: (value) {
                  if( value!.isEmpty ) {
                    return "insira seu Peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura em cm",
                    labelStyle: TextStyle(color: Colors.redAccent)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.redAccent, fontSize: 25),
                controller: hieghtController,
                validator: (value) {
                  if( value!.isEmpty ) {
                    return "insira sua Altura!";
                  }
                },
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()) {
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )),
                    color: Colors.redAccent,
                  )),
              Text(_infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.redAccent, fontSize: 25))
            ],
          ),
        ),
      ),
    );
  }
}
