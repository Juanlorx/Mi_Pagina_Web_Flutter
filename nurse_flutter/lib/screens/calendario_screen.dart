import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarioScreen extends StatefulWidget {
  const CalendarioScreen({super.key});

  @override
  State<CalendarioScreen> createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {

  DateTime mesActual = DateTime.now();

  final List<Map<String, dynamic>> citas = [
    {
      "paciente": "María González",
      "enfermera": "Ana Pérez",
      "tipo": "Consulta de enfermería",
      "fecha": DateTime.now(),
      "inicio": "08:00",
      "fin": "09:00",
      "estado": "Programada",
      "notas": "Control de presión arterial."
    },
    {
      "paciente": "Carlos Ramírez",
      "enfermera": "Laura Díaz",
      "tipo": "Visita domiciliaria",
      "fecha": DateTime.now().add(const Duration(days: 2)),
      "inicio": "10:30",
      "fin": "11:30",
      "estado": "Programada",
      "notas": "Revisión de tratamiento."
    },
    {
      "paciente": "Juan Torres",
      "enfermera": "Ana Pérez",
      "tipo": "Administración de medicamento",
      "fecha": DateTime.now().add(const Duration(days: 4)),
      "inicio": "15:00",
      "fin": "15:30",
      "estado": "Cancelada",
      "notas": ""
    },
  ];

  final pacienteController = TextEditingController();
  final enfermeraController = TextEditingController();
  final notasController = TextEditingController();

  String tipoSeleccionado = "Consulta de enfermería";
  DateTime fechaSeleccionada = DateTime.now();
  TimeOfDay horaInicio = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay horaFin = const TimeOfDay(hour: 9, minute: 0);

  void cambiarMes(int direccion) {
    setState(() {
      mesActual = DateTime(
        mesActual.year,
        mesActual.month + direccion,
      );
    });
  }

  List<Map<String, dynamic>> citasDia(int dia) {
    return citas.where((cita) {
      DateTime fecha = cita["fecha"];
      return fecha.year == mesActual.year &&
          fecha.month == mesActual.month &&
          fecha.day == dia;
    }).toList();
  }

  void agregarCita() {
    if (pacienteController.text.isEmpty ||
        enfermeraController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa todos los campos.")),
      );
      return;
    }

    setState(() {
      citas.add({
        "paciente": pacienteController.text,
        "enfermera": enfermeraController.text,
        "tipo": tipoSeleccionado,
        "fecha": fechaSeleccionada,
        "inicio": horaInicio.format(context),
        "fin": horaFin.format(context),
        "estado": "Programada",
        "notas": notasController.text,
      });
    });

    pacienteController.clear();
    enfermeraController.clear();
    notasController.clear();

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Cita agendada correctamente.")),
    );
  }

  void cancelarCita(int index) {
    setState(() {
      citas[index]["estado"] = "Cancelada";
    });
  }

  @override
  Widget build(BuildContext context) {
    final nombreMes = DateFormat("MMMM yyyy", "es_ES").format(mesActual);
    final diasMes =
        DateUtils.getDaysInMonth(mesActual.year, mesActual.month);

    final primerDia =
        DateTime(mesActual.year, mesActual.month, 1).weekday;

    return Scaffold(
      backgroundColor: const Color(0xffF3F6FB),
      appBar: AppBar(
        backgroundColor: const Color(0xff0F172A),
        title: const Text("Agenda de Enfermería"),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff2563EB),
        onPressed: mostrarFormulario,
        icon: const Icon(Icons.add),
        label: const Text("Agendar cita"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Organiza cada visita con claridad",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "Programa atenciones, consulta horarios y evita cruces en la agenda.",
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => cambiarMes(-1),
                        icon: const Icon(Icons.chevron_left),
                      ),
                      Text(
                        nombreMes.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      IconButton(
                        onPressed: () => cambiarMes(1),
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),

                  const Divider(),

                  GridView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: diasMes + primerDia - 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                    ),
                    itemBuilder: (_, index) {
                      if (index < primerDia - 1) {
                        return const SizedBox();
                      }

                      int dia = index - primerDia + 2;

                      List<Map<String, dynamic>> eventos =
                          citasDia(dia);

                      bool hoy = dia == DateTime.now().day &&
                          mesActual.month == DateTime.now().month &&
                          mesActual.year == DateTime.now().year;

                      return Container(
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: hoy
                              ? Colors.blue.shade100
                              : Colors.grey.shade100,
                          borderRadius:
                              BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            Text(
                              "$dia",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),

                            ...eventos.map((e) => Container(
                                  margin:
                                      const EdgeInsets.only(
                                          top: 2),
                                  padding:
                                      const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: e["estado"] ==
                                            "Cancelada"
                                        ? Colors.red.shade300
                                        : Colors.green.shade400,
                                    borderRadius:
                                        BorderRadius.circular(
                                            5),
                                  ),
                                  child: Text(
                                    e["inicio"],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10),
                                  ),
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Citas del mes",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ...List.generate(citas.length, (index) {
              final cita = citas[index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(

                  leading: CircleAvatar(
                    backgroundColor:
                        cita["estado"] == "Cancelada"
                            ? Colors.red
                            : Colors.green,
                    child: const Icon(Icons.medical_services,
                        color: Colors.white),
                  ),

                  title: Text(cita["paciente"]),

                  subtitle: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(cita["tipo"]),
                      Text(
                          "${DateFormat("dd/MM/yyyy").format(cita["fecha"])}   ${cita["inicio"]} - ${cita["fin"]}"),
                      Text("Enfermera: ${cita["enfermera"]}"),
                      Text(
                        cita["estado"],
                        style: TextStyle(
                          color: cita["estado"] == "Cancelada"
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),

                  trailing: cita["estado"] == "Cancelada"
                      ? const Icon(Icons.cancel,
                          color: Colors.red)
                      : IconButton(
                          icon: const Icon(Icons.close,
                              color: Colors.red),
                          onPressed: () =>
                              cancelarCita(index),
                        ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  void mostrarFormulario() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModal) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    const Text(
                      "Nueva cita",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: pacienteController,
                      decoration: const InputDecoration(
                        labelText: "Paciente",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: enfermeraController,
                      decoration: const InputDecoration(
                        labelText: "Enfermera",
                        prefixIcon:
                            Icon(Icons.health_and_safety),
                      ),
                    ),

                    const SizedBox(height: 15),

                    DropdownButtonFormField<String>(
                      value: tipoSeleccionado,
                      decoration: const InputDecoration(
                          labelText: "Tipo de atención"),
                      items: const [
                        DropdownMenuItem(
                            value:
                                "Consulta de enfermería",
                            child: Text(
                                "Consulta de enfermería")),
                        DropdownMenuItem(
                            value: "Visita domiciliaria",
                            child:
                                Text("Visita domiciliaria")),
                        DropdownMenuItem(
                            value:
                                "Control de tratamiento",
                            child: Text(
                                "Control de tratamiento")),
                        DropdownMenuItem(
                            value:
                                "Administración de medicamento",
                            child: Text(
                                "Administración de medicamento")),
                      ],
                      onChanged: (value) {
                        setModal(() {
                          tipoSeleccionado = value!;
                        });
                      },
                    ),

                    const SizedBox(height: 15),

                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: Text(
                        DateFormat("dd/MM/yyyy")
                            .format(fechaSeleccionada),
                      ),
                      onTap: () async {
                        DateTime? fecha =
                            await showDatePicker(
                          context: context,
                          initialDate: fechaSeleccionada,
                          firstDate: DateTime(2025),
                          lastDate: DateTime(2030),
                        );

                        if (fecha != null) {
                          setModal(() {
                            fechaSeleccionada = fecha;
                          });
                        }
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.access_time),
                      title:
                          Text("Hora inicio: ${horaInicio.format(context)}"),
                      onTap: () async {
                        TimeOfDay? hora =
                            await showTimePicker(
                          context: context,
                          initialTime: horaInicio,
                        );

                        if (hora != null) {
                          setModal(() => horaInicio = hora);
                        }
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.timer),
                      title:
                          Text("Hora fin: ${horaFin.format(context)}"),
                      onTap: () async {
                        TimeOfDay? hora =
                            await showTimePicker(
                          context: context,
                          initialTime: horaFin,
                        );

                        if (hora != null) {
                          setModal(() => horaFin = hora);
                        }
                      },
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: notasController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: "Notas",
                        alignLabelWithHint: true,
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xff2563EB),
                          padding:
                              const EdgeInsets.all(15),
                        ),
                        onPressed: agregarCita,
                        icon: const Icon(Icons.check),
                        label:
                            const Text("Confirmar cita"),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}