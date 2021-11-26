import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_logic.dart';

class LoginPage extends StatelessWidget {
  final logic = Get.find<LoginLogic>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                right: 0,
                left: 0,
                top: 0,
                child: Container(
                  color: Colors.white,
                  width: size.width,
                  height: size.height * 0.25,
                  padding: const EdgeInsets.all(25),
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              Positioned(
                top: size.height * 0.25,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xff1E4280),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  width: size.width,
                  height: size.height * 0.77,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      child: Form(
                          key: logic.formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                width: size.width,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: const TextSpan(children: [
                                        TextSpan(
                                            text: '¡Inicia sesión!\n\n',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                'Inicia sesión para recibir\nnotificaciones UNIFRONT\n',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 28))
                                      ])),
                                ),
                              ),
                              TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: logic.correoCtrl,
                                  decoration: InputDecoration(
                                    labelText: 'Correo',
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  validator: (value) =>
                                      logic.validateEmail(value),
                                  keyboardType: TextInputType.emailAddress),
                              const SizedBox(height: 20),
                              DropdownButtonFormField<String>(
                                value: logic.typeUser,
                                dropdownColor: const Color(0xff1E4280),
                                iconEnabledColor: Colors.white,
                                decoration: InputDecoration(
                                  labelText: 'Tipo de usuario',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                      value: 'Apoderado',
                                      child: Text('Apoderado',
                                          style:
                                              TextStyle(color: Colors.white))),
                                  DropdownMenuItem(
                                      value: 'Estudiante',
                                      child: Text('Estudiante',
                                          style:
                                              TextStyle(color: Colors.white)))
                                ],
                                onChanged: logic.onChangeTypeUser,
                                validator: (value) => logic.isNotEmpty(
                                    value, 'Seleccione un tipo de usuario'),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: logic.passwordCtrl,
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                ),
                                validator: (value) => logic.isNotEmpty(
                                    value, 'Ingrese su contraseña'),
                                obscureText: true,
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color(0xffF4C300),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16))),
                                    onPressed: logic.login,
                                    child: const Text(
                                      'Iniciar sesión',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
