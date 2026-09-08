import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_decoration.dart';
import '../styles/app_sizes.dart';
import '../styles/app_text_styles.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      // ================= APPBAR =================

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,

        title: const Text(
          "NURSE",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/login',
              );
            },
          ),
        ],
      ),

      // ================= MENÚ LATERAL =================

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,

          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.secondary,
                  ],
                ),
              ),

              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [
                  Image.asset(
                    "assets/images/nurse_logo.png",
                    height: 90,
                    width: 90,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "NURSE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // ================= INICIO =================

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Inicio"),

              onTap: () {
                Navigator.pop(context);
              },
            ),

            // ================= PACIENTES =================

            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Pacientes"),

              onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(
                  context,
                  '/pacientes',
                );
              },
            ),

            // ================= CALENDARIO =================

            ListTile(
              leading:
                  const Icon(Icons.calendar_month),

              title: const Text("Calendario"),

              onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(
                  context,
                  '/calendario',
                );
              },
            ),

            const Divider(),

            // ================= CERRAR SESIÓN =================

            ListTile(
              leading: const Icon(Icons.logout),

              title: const Text("Cerrar sesión"),

              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/login',
                );
              },
            ),
          ],
        ),
      ),

      // ================= CONTENIDO =================

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

              // ================= BIENVENIDA =================

              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(
                  AppSizes.padding,
                ),

                decoration:
                    AppDecoration.loginContainer,

                child: Column(
                  children: [

                    Image.asset(
                      "assets/images/nurse_logo.png",
                      height: 200,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Bienvenido a NURSE",
                      style:
                          AppTextStyles.titulo,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Sistema para la gestión de pacientes y atención domiciliaria.",
                      textAlign:
                          TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ================= ACCESOS RÁPIDOS =================

              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(20),

                decoration:
                    AppDecoration.loginContainer,

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "Accesos rápidos",
                      style:
                          AppTextStyles.titulo,
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [

                        // PACIENTES

                        Expanded(
                          child:
                              ElevatedButton.icon(
                            style:
                                ElevatedButton
                                    .styleFrom(
                              backgroundColor:
                                  AppColors
                                      .primary,

                              foregroundColor:
                                  Colors.white,

                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                vertical: 15,
                              ),
                            ),

                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/pacientes',
                              );
                            },

                            icon: const Icon(
                              Icons.people,
                            ),

                            label: const Text(
                              "Pacientes",
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),

                        // CALENDARIO

                        Expanded(
                          child:
                              ElevatedButton.icon(
                            style:
                                ElevatedButton
                                    .styleFrom(
                              backgroundColor:
                                  Colors.green,

                              foregroundColor:
                                  Colors.white,

                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                vertical: 15,
                              ),
                            ),

                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/calendario',
                              );
                            },

                            icon: const Icon(
                              Icons.calendar_month,
                            ),

                            label: const Text(
                              "Calendario",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ================= GALERÍA =================

              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(20),

                decoration:
                    AppDecoration.loginContainer,

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "Galería",
                      style:
                          AppTextStyles.titulo,
                    ),

                    const SizedBox(height: 20),

                    GridView.count(
                      shrinkWrap: true,

                      physics:
                          const NeverScrollableScrollPhysics(),

                      crossAxisCount: 2,

                      crossAxisSpacing: 15,

                      mainAxisSpacing: 15,

                      children: [
                        imagenCard(
                          "assets/images/enfermera.jpg",
                        ),

                        imagenCard(
                          "assets/images/pastillas.jpg",
                        ),

                        imagenCard(
                          "assets/images/tapabocas.jpg",
                        ),

                        imagenCard(
                          "assets/images/pulso.jpg",
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ================= INFORMACIÓN =================

              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(20),

                decoration:
                    AppDecoration.loginContainer,

                child: Column(
                  children: [

                    const Text(
                      "¿Qué es NURSE?",
                      style:
                          AppTextStyles.titulo,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "NURSE es una plataforma desarrollada para apoyar a las enfermeras en la administración de pacientes, tratamientos, medicamentos, horarios y visitas domiciliarias.\n\n"
                      "Permite organizar toda la información clínica desde una sola aplicación, optimizando el tiempo y mejorando la atención de los pacientes.",

                      textAlign:
                          TextAlign.justify,

                      style: TextStyle(
                        fontSize: 16,
                        height: 1.7,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ================= CALENDARIO =================

              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(20),

                decoration:
                    AppDecoration.loginContainer,

                child: Column(
                  children: [

                    const Icon(
                      Icons.calendar_month,
                      size: 70,
                      color: Colors.green,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Agenda de Enfermería",
                      style:
                          AppTextStyles.titulo,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Consulta las citas programadas, registra nuevas visitas domiciliarias y organiza los horarios de atención.",

                      textAlign:
                          TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,

                      child:
                          ElevatedButton.icon(
                        style:
                            ElevatedButton
                                .styleFrom(
                          backgroundColor:
                              Colors.green,

                          foregroundColor:
                              Colors.white,

                          padding:
                              const EdgeInsets
                                  .symmetric(
                            vertical: 15,
                          ),
                        ),

                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/calendario',
                          );
                        },

                        icon: const Icon(
                          Icons.calendar_today,
                        ),

                        label: const Text(
                          "Abrir Calendario",
                        ),
                      ),
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

  // ================= TARJETAS DE IMAGEN =================

  static Widget imagenCard(String ruta) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(15),

      child: Image.asset(
        ruta,

        fit: BoxFit.cover,

        errorBuilder:
            (context, error, stackTrace) {
          return Container(
            color: Colors.red.shade100,

            alignment: Alignment.center,

            child: Text(
              "No se encontró:\n$ruta",

              textAlign:
                  TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}