import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_decoration.dart';
import '../styles/app_text_styles.dart';
import '../widgets/custom_button.dart';

class PacientesScreen extends StatefulWidget {
  const PacientesScreen({super.key});

  @override
  State<PacientesScreen> createState() => _PacientesScreenState();
}

class _PacientesScreenState extends State<PacientesScreen> {

  final nombreController = TextEditingController();
  final cedulaController = TextEditingController();
  final medicamentoController = TextEditingController();
  final condicionController = TextEditingController();

  List<Map<String, dynamic>> pacientes = [];

  void registrarPaciente() {

    if (nombreController.text.isEmpty ||
        cedulaController.text.isEmpty ||
        medicamentoController.text.isEmpty ||
        condicionController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Complete todos los campos"),
        ),
      );

      return;
    }

    setState(() {

      pacientes.add({

        "nombre": nombreController.text,
        "cedula": cedulaController.text,
        "medicamento": medicamentoController.text,
        "condicion": condicionController.text,
        "revisado": false,

      });

      nombreController.clear();
      cedulaController.clear();
      medicamentoController.clear();
      condicionController.clear();

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Gestión de Pacientes"),

        backgroundColor: AppColors.primary,

        foregroundColor: Colors.white,

      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Container(

              decoration: AppDecoration.loginContainer,

              padding: const EdgeInsets.all(20),

              child: Column(

                children: [

                  const Text(
                    "Registrar Paciente",
                    style: AppTextStyles.titulo,
                  ),

                  const SizedBox(height: 20),

                  TextField(

                    controller: nombreController,

                    decoration: const InputDecoration(

                      labelText: "Nombre",

                      prefixIcon: Icon(Icons.person),

                    ),

                  ),

                  const SizedBox(height: 15),

                  TextField(

                    controller: cedulaController,

                    decoration: const InputDecoration(

                      labelText: "Cédula",

                      prefixIcon: Icon(Icons.badge),

                    ),

                  ),

                  const SizedBox(height: 15),

                  TextField(

                    controller: medicamentoController,

                    decoration: const InputDecoration(

                      labelText: "Medicamentos",

                      prefixIcon: Icon(Icons.medication),

                    ),

                  ),

                  const SizedBox(height: 15),

                  TextField(

                    controller: condicionController,

                    decoration: const InputDecoration(

                      labelText: "Condición",

                      prefixIcon: Icon(Icons.favorite),

                    ),

                  ),

                  const SizedBox(height: 25),

                  CustomButton(

                    text: "Registrar Paciente",

                    onPressed: registrarPaciente,

                  ),

                ],

              ),

            ),

            const SizedBox(height: 30),

            const Align(

              alignment: Alignment.centerLeft,

              child: Text(

                "Pacientes Registrados",

                style: AppTextStyles.titulo,

              ),

            ),

            const SizedBox(height: 15),
                        if (pacientes.isEmpty)

              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(30),

                decoration: AppDecoration.loginContainer,

                child: const Center(

                  child: Column(

                    children: [

                      Icon(
                        Icons.people_alt_outlined,
                        size: 70,
                        color: AppColors.grey,
                      ),

                      SizedBox(height: 15),

                      Text(
                        "No hay pacientes registrados",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],

                  ),

                ),

              )

            else

              ListView.builder(

                shrinkWrap: true,

                physics: const NeverScrollableScrollPhysics(),

                itemCount: pacientes.length,

                itemBuilder: (context, index) {

                  final paciente = pacientes[index];

                  return Card(

                    elevation: 4,

                    margin: const EdgeInsets.only(bottom: 15),

                    shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(15),

                    ),

                    child: Padding(

                      padding: const EdgeInsets.all(15),

                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Checkbox(

                            value: paciente["revisado"],

                            activeColor: AppColors.primary,

                            onChanged: (valor) {

                              setState(() {

                                paciente["revisado"] = valor!;

                              });

                            },

                          ),

                          const SizedBox(width: 10),

                          Expanded(

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                Text(

                                  paciente["nombre"],

                                  style: const TextStyle(

                                    fontSize: 18,

                                    fontWeight: FontWeight.bold,

                                  ),

                                ),

                                const SizedBox(height: 8),

                                Row(

                                  children: [

                                    const Icon(

                                      Icons.badge,

                                      size: 18,

                                      color: AppColors.primary,

                                    ),

                                    const SizedBox(width: 6),

                                    Text("CC: ${paciente["cedula"]}"),

                                  ],

                                ),

                                const SizedBox(height: 5),

                                Row(

                                  children: [

                                    const Icon(

                                      Icons.medication,

                                      size: 18,

                                      color: Colors.red,

                                    ),

                                    const SizedBox(width: 6),

                                    Expanded(

                                      child: Text(

                                        paciente["medicamento"],

                                      ),

                                    ),

                                  ],

                                ),

                                const SizedBox(height: 5),

                                Row(

                                  children: [

                                    const Icon(

                                      Icons.favorite,

                                      size: 18,

                                      color: Colors.pink,

                                    ),

                                    const SizedBox(width: 6),

                                    Expanded(

                                      child: Text(

                                        paciente["condicion"],

                                      ),

                                    ),

                                  ],

                                ),

                              ],

                            ),

                          ),

                          IconButton(

                            icon: const Icon(

                              Icons.delete,

                              color: Colors.red,

                            ),

                            onPressed: () {

                              setState(() {

                                pacientes.removeAt(index);

                              });

                            },

                          ),

                        ],

                      ),

                    ),

                  );

                },

              ),
                      ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nombreController.dispose();
    cedulaController.dispose();
    medicamentoController.dispose();
    condicionController.dispose();
    super.dispose();
  }
}