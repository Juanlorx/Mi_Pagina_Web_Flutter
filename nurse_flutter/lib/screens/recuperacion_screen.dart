import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_sizes.dart';
import '../styles/app_text_styles.dart';
import '../widgets/custom_button.dart';

class RecuperacionScreen extends StatefulWidget {
  const RecuperacionScreen({super.key});

  @override
  State<RecuperacionScreen> createState() => _RecuperacionScreenState();
}

class _RecuperacionScreenState extends State<RecuperacionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController correoController = TextEditingController();

  @override
  void dispose() {
    correoController.dispose();
    super.dispose();
  }

  void recuperarContrasena() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Se enviaron las instrucciones al correo electrónico.",
          ),
          backgroundColor: Colors.green,
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pop(context);
        }
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
                    blurRadius: 25,
                    offset: Offset(0, 12),
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
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.local_hospital,
                            size: 120,
                            color: AppColors.primary,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Recuperar Contraseña",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titulo,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Ingrese el correo electrónico asociado a su cuenta.\n\n"
                      "Le enviaremos las instrucciones para recuperar su contraseña.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.grey,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextFormField(
                      controller: correoController,
                      keyboardType: TextInputType.emailAddress,

                      decoration: const InputDecoration(
                        labelText: "Correo electrónico",
                        hintText: "Ingrese su correo",
                        prefixIcon: Icon(Icons.email),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese su correo";
                        }

                        if (!value.contains("@")) {
                          return "Correo electrónico inválido";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    CustomButton(
                      text: "Enviar recuperación",
                      onPressed: recuperarContrasena,
                    ),

                    const SizedBox(height: 20),

                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.secondary,
                      ),

                      label: const Text(
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