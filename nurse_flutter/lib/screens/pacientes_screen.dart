import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_decoration.dart';
import '../styles/app_sizes.dart';
import '../styles/app_text_styles.dart';

class PacientesScreen extends StatefulWidget {
  const PacientesScreen({super.key});

  @override
  State<PacientesScreen> createState() => _PacientesScreenState();
}

class _PacientesScreenState extends State<PacientesScreen> {
  final TextEditingController fechaController =
      TextEditingController();

  final TextEditingController diagnosticoController =
      TextEditingController();

  final TextEditingController usuarioController =
      TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  // =========================
  // LISTA DE PACIENTES
  // =========================

  final List<Map<String, dynamic>> pacientes = [];

  int? pacienteEditando;

  @override
  void dispose() {
    fechaController.dispose();
    diagnosticoController.dispose();
    usuarioController.dispose();
    super.dispose();
  }

  // =========================
  // LIMPIAR FORMULARIO
  // =========================

  void limpiarFormulario() {
    fechaController.clear();
    diagnosticoController.clear();
    usuarioController.clear();

    setState(() {
      pacienteEditando = null;
    });
  }

  // =========================
  // GUARDAR / ACTUALIZAR
  // =========================

  void guardarPaciente() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (pacienteEditando != null) {
      final index = pacientes.indexWhere(
        (paciente) =>
            paciente['id'] == pacienteEditando,
      );

      if (index != -1) {
        setState(() {
          pacientes[index] = {
            'id': pacienteEditando,
            'fecha': fechaController.text,
            'diagnostico':
                diagnosticoController.text,
            'usuario':
                usuarioController.text,
          };
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Paciente actualizado correctamente'),
        ),
      );
    } else {
      final nuevoId =
          pacientes.isEmpty
              ? 1
              : pacientes.last['id'] + 1;

      setState(() {
        pacientes.add({
          'id': nuevoId,
          'fecha': fechaController.text,
          'diagnostico':
              diagnosticoController.text,
          'usuario':
              usuarioController.text,
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Paciente guardado correctamente'),
        ),
      );
    }

    limpiarFormulario();
  }

  // =========================
  // EDITAR
  // =========================

  void editarPaciente(
      Map<String, dynamic> paciente) {
    setState(() {
      pacienteEditando = paciente['id'];

      fechaController.text =
          paciente['fecha'].toString();

      diagnosticoController.text =
          paciente['diagnostico'].toString();

      usuarioController.text =
          paciente['usuario'].toString();
    });
  }

  // =========================
  // ELIMINAR
  // =========================

  void eliminarPaciente(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Eliminar paciente',
          ),
          content: const Text(
            '¿Desea eliminar este paciente?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  pacientes.removeWhere(
                    (paciente) =>
                        paciente['id'] == id,
                  );
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Paciente eliminado correctamente',
                    ),
                  ),
                );
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // SELECCIONAR FECHA
  // =========================

  Future<void> seleccionarFecha() async {
    final fecha =
        await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('es', 'ES'),
    );

    if (fecha != null) {
      final dia =
          fecha.day.toString().padLeft(2, '0');

      final mes =
          fecha.month.toString().padLeft(2, '0');

      final anio =
          fecha.year.toString();

      setState(() {
        fechaController.text =
            '$anio-$mes-$dia';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      // =========================
      // APP BAR
      // =========================

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: true,

        title: const Text(
          'NURSE',
          style: TextStyle(
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

      // =========================
      // CONTENIDO
      // =========================

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

              // =========================
              // ENCABEZADO
              // =========================

              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(20),

                decoration:
                    AppDecoration.loginContainer,

                child: Column(
                  children: [

                    const Icon(
                      Icons.people,
                      size: 70,
                      color: AppColors.primary,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Gestión de Pacientes',
                      textAlign:
                          TextAlign.center,

                      style:
                          AppTextStyles.titulo,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Total Pacientes: ${pacientes.length}',

                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // =========================
              // FORMULARIO
              // =========================

              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(20),

                decoration:
                    AppDecoration.loginContainer,

                child: Form(
                  key: _formKey,

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(
                        pacienteEditando == null
                            ? 'Registrar paciente'
                            : 'Actualizar paciente',

                        style:
                            AppTextStyles.titulo,
                      ),

                      const SizedBox(height: 20),

                      // FECHA

                      TextFormField(
                        controller:
                            fechaController,

                        readOnly: true,

                        onTap:
                            seleccionarFecha,

                        decoration:
                            const InputDecoration(
                          labelText:
                              'Fecha de nacimiento',

                          prefixIcon:
                              Icon(
                            Icons.calendar_today,
                          ),

                          border:
                              OutlineInputBorder(),
                        ),

                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Seleccione la fecha de nacimiento';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      // DIAGNÓSTICO

                      TextFormField(
                        controller:
                            diagnosticoController,

                        decoration:
                            const InputDecoration(
                          labelText:
                              'Diagnóstico',

                          hintText:
                              'Ingrese el diagnóstico',

                          prefixIcon:
                              Icon(
                            Icons.medical_information,
                          ),

                          border:
                              OutlineInputBorder(),
                        ),

                        maxLines: 2,

                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Ingrese el diagnóstico';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      // ID USUARIO

                      TextFormField(
                        controller:
                            usuarioController,

                        keyboardType:
                            TextInputType.number,

                        decoration:
                            const InputDecoration(
                          labelText:
                              'ID Usuario',

                          hintText:
                              'Ingrese el ID del usuario',

                          prefixIcon:
                              Icon(Icons.person),

                          border:
                              OutlineInputBorder(),
                        ),

                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Ingrese el ID Usuario';
                          }

                          if (int.tryParse(
                                  value) ==
                              null) {
                            return 'Ingrese un ID válido';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // BOTONES

                      Row(
                        children: [

                          Expanded(
                            child:
                                ElevatedButton.icon(
                              onPressed:
                                  guardarPaciente,

                              icon: Icon(
                                pacienteEditando ==
                                        null
                                    ? Icons.save
                                    : Icons.edit,
                              ),

                              label: Text(
                                pacienteEditando ==
                                        null
                                    ? 'Guardar'
                                    : 'Actualizar',
                              ),

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
                            ),
                          ),

                          if (pacienteEditando !=
                              null) ...[
                            const SizedBox(width: 10),

                            Expanded(
                              child:
                                  OutlinedButton.icon(
                                onPressed:
                                    limpiarFormulario,

                                icon: const Icon(
                                  Icons.cancel,
                                ),

                                label:
                                    const Text(
                                  'Cancelar',
                                ),

                                style:
                                    OutlinedButton
                                        .styleFrom(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    vertical: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // =========================
              // LISTA DE PACIENTES
              // =========================

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
                      'Pacientes registrados',

                      style:
                          AppTextStyles.titulo,
                    ),

                    const SizedBox(height: 20),

                    if (pacientes.isEmpty)
                      Container(
                        width:
                            double.infinity,

                        padding:
                            const EdgeInsets.all(
                          25,
                        ),

                        decoration:
                            BoxDecoration(
                          color:
                              Colors.grey.shade100,

                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                        ),

                        child: const Column(
                          children: [

                            Icon(
                              Icons.people_outline,
                              size: 60,
                              color: Colors.grey,
                            ),

                            SizedBox(height: 10),

                            Text(
                              'No hay pacientes registrados.',
                              textAlign:
                                  TextAlign.center,

                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,

                        physics:
                            const NeverScrollableScrollPhysics(),

                        itemCount:
                            pacientes.length,

                        itemBuilder:
                            (context, index) {

                          final paciente =
                              pacientes[index];

                          return Card(
                            margin:
                                const EdgeInsets.only(
                              bottom: 12,
                            ),

                            elevation: 2,

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                12,
                              ),
                            ),

                            child: Padding(
                              padding:
                                  const EdgeInsets.all(
                                15,
                              ),

                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  Row(
                                    children: [

                                      CircleAvatar(
                                        backgroundColor:
                                            AppColors
                                                .primary,

                                        child:
                                            const Icon(
                                          Icons.person,
                                          color:
                                              Colors.white,
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 12,
                                      ),

                                      Expanded(
                                        child: Text(
                                          'Paciente #${paciente['id']}',

                                          style:
                                              const TextStyle(
                                            fontSize: 18,
                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const Divider(
                                    height: 25,
                                  ),

                                  Row(
                                    children: [

                                      const Icon(
                                        Icons
                                            .calendar_today,
                                        size: 20,
                                      ),

                                      const SizedBox(
                                        width: 8,
                                      ),

                                      Expanded(
                                        child: Text(
                                          'Nacimiento: ${paciente['fecha']}',
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,

                                    children: [

                                      const Icon(
                                        Icons
                                            .medical_information,
                                        size: 20,
                                      ),

                                      const SizedBox(
                                        width: 8,
                                      ),

                                      Expanded(
                                        child: Text(
                                          'Diagnóstico: ${paciente['diagnostico']}',
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    children: [

                                      const Icon(
                                        Icons.person,
                                        size: 20,
                                      ),

                                      const SizedBox(
                                        width: 8,
                                      ),

                                      Text(
                                        'ID Usuario: ${paciente['usuario']}',
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 15,
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .end,

                                    children: [

                                      TextButton.icon(
                                        onPressed: () {
                                          editarPaciente(
                                            paciente,
                                          );
                                        },

                                        icon:
                                            const Icon(
                                          Icons.edit,
                                        ),

                                        label:
                                            const Text(
                                          'Editar',
                                        ),
                                      ),

                                      TextButton.icon(
                                        onPressed: () {
                                          eliminarPaciente(
                                            paciente['id'],
                                          );
                                        },

                                        icon:
                                            const Icon(
                                          Icons.delete,
                                          color:
                                              Colors.red,
                                        ),

                                        label:
                                            const Text(
                                          'Eliminar',
                                          style:
                                              TextStyle(
                                            color:
                                                Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
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

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}