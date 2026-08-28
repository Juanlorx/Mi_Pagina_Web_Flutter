import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_sizes.dart';
import '../styles/app_text_styles.dart';
import '../widgets/custom_button.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController documentoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController rethusController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? tipoDocumento;
  bool aceptaPolitica = false;

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    documentoController.dispose();
    telefonoController.dispose();
    direccionController.dispose();
    rethusController.dispose();
    correoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void registrar() {
    if (_formKey.currentState!.validate()) {
      if (!aceptaPolitica) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Debe aceptar la política de datos."),
          ),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuario registrado correctamente."),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.secondary,
            ],
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Container(
              width: AppSizes.containerWidth,

              padding: const EdgeInsets.all(AppSizes.padding),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(AppSizes.containerRadius),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 25,
                    offset: Offset(0, 10),
                  ),
                ],
              ),

              child: Form(
                key: _formKey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [

                    Center(
                      child: Image.asset(
                        "assets/images/nurse_logo.png",
                        width: 140,
                        height: 140,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "REGISTRARSE",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titulo,
                    ),

                    const SizedBox(height: 30),

                    TextFormField(
                      controller: nombreController,
                      decoration: const InputDecoration(
                        labelText: "Nombre",
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese su nombre";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: apellidoController,
                      decoration: const InputDecoration(
                        labelText: "Apellido",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese su apellido";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    DropdownButtonFormField<String>(
                      value: tipoDocumento,

                      decoration: const InputDecoration(
                        labelText: "Tipo de documento",
                        prefixIcon: Icon(Icons.badge),
                      ),

                      items: const [
                        DropdownMenuItem(
                          value: "CC",
                          child: Text("Cédula de ciudadanía"),
                        ),
                        DropdownMenuItem(
                          value: "TI",
                          child: Text("Tarjeta de identidad"),
                        ),
                        DropdownMenuItem(
                          value: "CE",
                          child: Text("Cédula de extranjería"),
                        ),
                        DropdownMenuItem(
                          value: "PAS",
                          child: Text("Pasaporte"),
                        ),
                      ],

                      onChanged: (value) {
                        setState(() {
                          tipoDocumento = value;
                        });
                      },

                      validator: (value) {
                        if (value == null) {
                          return "Seleccione un tipo";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: documentoController,
                      keyboardType: TextInputType.number,

                      decoration: const InputDecoration(
                        labelText: "Número de documento",
                        prefixIcon: Icon(Icons.credit_card),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese el documento";
                        }
                        return null;
                      },
                    ),
                                        const SizedBox(height: 15),

                    TextFormField(
                      controller: telefonoController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Teléfono",
                        prefixIcon: Icon(Icons.phone),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese su teléfono";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: direccionController,
                      decoration: const InputDecoration(
                        labelText: "Dirección",
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese su dirección";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: rethusController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "RETHUS",
                        prefixIcon: Icon(Icons.badge),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese su RETHUS";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: correoController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Correo electrónico",
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese su correo";
                        }

                        if (!value.contains("@")) {
                          return "Correo inválido";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Contraseña",
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese una contraseña";
                        }

                        if (value.length < 6) {
                          return "Mínimo 6 caracteres";
                        }

                        return null;
                      },
                    ),
                                        const SizedBox(height: 20),

                    CheckboxListTile(
                      value: aceptaPolitica,

                      controlAffinity:
                          ListTileControlAffinity.leading,

                      title: const Text(
                        "Acepto la política de tratamiento de datos personales",
                        style: TextStyle(fontSize: 14),
                      ),

                      onChanged: (value) {
                        setState(() {
                          aceptaPolitica = value!;
                        });
                      },
                    ),

                    const SizedBox(height: 25),

                    CustomButton(
                      text: "Registrarse",
                      onPressed: registrar,
                    ),

                    const SizedBox(height: 15),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Volver al inicio de sesión",
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}