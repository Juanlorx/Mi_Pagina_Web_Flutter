import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_sizes.dart';
import '../styles/app_text_styles.dart';

import '../widgets/custom_button.dart';

import 'menu_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController rethusController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? rolSeleccionado; 
  String? mensajeError;

  @override
  void dispose() {
    emailController.dispose();
    rethusController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
  if (_formKey.currentState!.validate()) {
    setState(() {
      mensajeError = null;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MenuPage(),
      ),
    );
  } else {
    setState(() {
      mensajeError = "Complete todos los campos.";
    });
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
                    blurRadius: 35,
                    offset: Offset(0, 15),
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
    'assets/images/nurse_logo.png',
    width: 180,
    height: 180,
    fit: BoxFit.contain,
    errorBuilder: (context, error, stackTrace) {
      return Container(
        width: 180,
        height: 180,
        alignment: Alignment.center,
        child: const Text(
          'Error al cargar el logo',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    },
  ),
),
                    const SizedBox(height: 15),

                    const Text(
                      "Iniciar Sesión",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titulo,
                    ),

                    const SizedBox(height: 25),

                    if (mensajeError != null)
                      Container(
                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: AppColors.errorBackground,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.error,
                          ),
                        ),

                        child: Text(
                          mensajeError!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    if (mensajeError != null)
                      const SizedBox(height: 15),

                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Correo",
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese su correo";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: rethusController,
                      decoration: const InputDecoration(
                        labelText: "Rethus",
                        prefixIcon: Icon(Icons.badge),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese su Rethus";
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
                          return "Ingrese su contraseña";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    DropdownButtonFormField<String>(
                      value: rolSeleccionado,

                      decoration: const InputDecoration(
                        labelText: "Tipo de Usuario",
                        prefixIcon: Icon(Icons.person),
                      ),

                      items: const [

                        DropdownMenuItem(
                          value: "1",
                          child: Text("Administrador"),
                        ),

                        DropdownMenuItem(
                          value: "2",
                          child: Text("Enfermero"),
                        ),

                      ],

                      onChanged: (value) {
                        setState(() {
                          rolSeleccionado = value;
                        });
                      },

                      validator: (value) {
                        if (value == null) {
                          return "Seleccione un rol";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                   CustomButton(
                   text: "Ingresar",
                    onPressed: login,
                    ),

                    const SizedBox(height: 15),

                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/recuperacion',
                          );
                        },
                        child: const Text(
                          "¿Olvidaste tu contraseña?",
                        ),
                      ),

                                        TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/registro',
                          );
                        },
                        child: const Text(
                          "Crear Cuenta",
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