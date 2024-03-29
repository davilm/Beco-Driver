import 'package:flutter/material.dart';

import 'package:beco_driver/api/Authentication.dart';
import 'package:beco_driver/shared/models/user_model.dart';
import 'package:beco_driver/views/SignIn/SignIn.dart';
import 'package:beco_driver/views/SignUp/SignUpPassword.dart';

class SignUpName extends StatefulWidget {
  final UserModel newUser;

  SignUpName(this.newUser);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<SignUpName> {
  TextEditingController _nameController = TextEditingController();
  String _errorMessage = "";

  validarNome() {
    String name = _nameController.text;

    if (name.isNotEmpty && name.length > 5) {
      widget.newUser.name = _nameController.text;

      Authentication().signUp(
        widget.newUser.email,
        widget.newUser.name,
        widget.newUser.cpf,
        widget.newUser.password,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignIn(),
        ),
      );
    } else {
      setState(() {
        _errorMessage = "Digite seu nome e sobrenome";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Cadastro",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignUpPassword(widget.newUser)),
              );
            }),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.transparent)),

            //Campo insira cpf
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 110, left: 11),
                        child: Text(
                          "Qual seu nome?",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),

                    //TCampo digitar nome
                    Container(
                      width: MediaQuery.of(context).size.width / 1.09,
                      child: TextField(
                        controller: _nameController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(hintText: "Nome completo"),
                        autofocus: true,
                      ),
                    ),

                    //Campo Botao
                    Container(
                      width: MediaQuery.of(context).size.width / 1.09,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 1.65,
                            bottom: 8),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          color: Colors.black,
                          child: Text(
                            "Concluir",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            validarNome();
                          },
                        ),
                      ),
                    ),

                    Text(
                      _errorMessage,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
