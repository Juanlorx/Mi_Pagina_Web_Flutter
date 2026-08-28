import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_decoration.dart';
import '../styles/app_text_styles.dart';

class PanelScreen extends StatelessWidget {
  const PanelScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Dashboard NURSE"),

        backgroundColor: AppColors.primary,

        foregroundColor: Colors.white,

        actions: [

          IconButton(

            icon: const Icon(Icons.logout),

            onPressed: () {

              Navigator.pushReplacementNamed(context, "/login");

            },

          )

        ],

      ),

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

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            children: [

              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: AppDecoration.loginContainer,

                child: Column(

                  children: [

                    const Icon(

                      Icons.dashboard,

                      color: AppColors.primary,

                      size: 70,

                    ),

                    const SizedBox(height: 15),

                    const Text(

                      "Bienvenido a NURSE",

                      style: AppTextStyles.titulo,

                    ),

                    const SizedBox(height: 10),

                    const Text(

                      "Sistema de gestión y administración médica.",

                      textAlign: TextAlign.center,

                    ),

                  ],

                ),

              ),

              const SizedBox(height: 30),

              GridView.count(

                shrinkWrap: true,

                physics: const NeverScrollableScrollPhysics(),

                crossAxisCount: 2,

                crossAxisSpacing: 15,

                mainAxisSpacing: 15,

                childAspectRatio: 1.2,

                children: [

                  dashboardCard(
                    Icons.people,
                    "Usuarios",
                    "120",
                    Colors.blue,
                  ),

                  dashboardCard(
                    Icons.personal_injury,
                    "Pacientes",
                    "65",
                    Colors.green,
                  ),

                  dashboardCard(
                    Icons.medical_services,
                    "Enfermeras",
                    "18",
                    Colors.orange,
                  ),

                  dashboardCard(
                    Icons.medication,
                    "Medicamentos",
                    "240",
                    Colors.red,
                  ),

                  dashboardCard(
                    Icons.assignment,
                    "Tratamientos",
                    "40",
                    Colors.purple,
                  ),

                  dashboardCard(
                    Icons.schedule,
                    "Horarios",
                    "58",
                    Colors.teal,
                  ),

                  dashboardCard(
                    Icons.favorite,
                    "Atenciones",
                    "92",
                    Colors.pink,
                  ),

                  dashboardCard(
                    Icons.notifications,
                    "Notificaciones",
                    "31",
                    Colors.amber,
                  ),

                ],

              ),

              const SizedBox(height: 30),
                            Container(

                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: AppDecoration.loginContainer,

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "Administración",
                      style: AppTextStyles.titulo,
                    ),

                    const SizedBox(height: 20),

                    Wrap(

                      spacing: 15,

                      runSpacing: 15,

                      children: [

                        moduloCard(
                          context,
                          Icons.people,
                          "Usuarios",
                          Colors.blue,
                          () {},
                        ),

                        moduloCard(
                          context,
                          Icons.personal_injury,
                          "Pacientes",
                          Colors.green,
                          () {
                            Navigator.pushNamed(
                              context,
                              "/pacientes",
                            );
                          },
                        ),

                        moduloCard(
                          context,
                          Icons.medical_services,
                          "Enfermeras",
                          Colors.orange,
                          () {},
                        ),

                        moduloCard(
                          context,
                          Icons.medication,
                          "Medicamentos",
                          Colors.red,
                          () {},
                        ),

                        moduloCard(
                          context,
                          Icons.assignment,
                          "Tratamientos",
                          Colors.purple,
                          () {},
                        ),

                        moduloCard(
                          context,
                          Icons.schedule,
                          "Horarios",
                          Colors.teal,
                          () {},
                        ),

                        moduloCard(
                          context,
                          Icons.favorite,
                          "Atenciones",
                          Colors.pink,
                          () {},
                        ),

                        moduloCard(
                          context,
                          Icons.notifications,
                          "Notificaciones",
                          Colors.amber,
                          () {},
                        ),

                      ],

                    ),

                  ],

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }
    Widget dashboardCard(
    IconData icono,
    String titulo,
    String cantidad,
    Color color,
  ) {
    return Container(
      decoration: AppDecoration.loginContainer,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircleAvatar(
              radius: 28,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(
                icono,
                color: color,
                size: 30,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              cantidad,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget moduloCard(
    BuildContext context,
    IconData icono,
    String titulo,
    Color color,
    VoidCallback onTap,
  ) {
    return SizedBox(
      width: 170,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Icon(
                  icono,
                  size: 45,
                  color: color,
                ),

                const SizedBox(height: 12),

                Text(
                  titulo,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 15),

                ElevatedButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("Administrar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}