import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // VARIAVEIS
  final _tConta = TextEditingController();
  final _tPessoas = TextEditingController();
  final _tGruja = TextEditingController();
  var _infoText = "Se beber não dirija";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de prejuizo"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields(){
    _tConta.text = "";
    _tPessoas.text = "";
    _tGruja.text = "";
    setState(() {
      _infoText = "Se beber não dirija";
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Valor da conta", _tConta),
              _editText("Quantidade de Pessoas", _tPessoas),
              _editText("Porcentagem do garçom", _tGruja),
              _buttonCalcular(),
              _textInfo(),
            ],
          ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),
      ),
    );
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  // Widget button
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: RaisedButton(
        color: Colors.orange[500],
        child:
        Text(
          "Hora da verdade",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            _calculate();
          }
        },
      ),
    );
  }

  
  void _calculate(){
    setState(() {
      double conta = double.parse(_tConta.text);
      double pessoas = double.parse(_tPessoas.text);
      double porcentagem = double.parse(_tGruja.text)/100;
      double total = (1+porcentagem) * conta;
      double vpp = (1+porcentagem) * (conta / pessoas);
      double rico = porcentagem * conta;
      _infoText = "O valor total a pagar é ${total.toStringAsFixed(2)}\n \n O garçom ficou ${rico.toStringAsFixed(2)} R\$ mais rico \n \n Cada um deverá pagar ${vpp.toStringAsFixed(2)} R\$ ";
    });
  }

  // // Widget text
  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 23.0),
    );
  }
}
