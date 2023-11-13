import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/compare_dates_utils.dart';
import '../../domain/entities/todo_entity.dart';
import '../../../../ui/widgets/header_modal_bottom_widget.dart';

class CreateTaskWidget extends StatefulWidget {
  const CreateTaskWidget({Key? key}) : super(key: key);
  @override
  State<CreateTaskWidget> createState() => _CreateTaskWidgetState();
}

class _CreateTaskWidgetState extends State<CreateTaskWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder: (_, scrollController) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            HeaderModalBottomWidget(
              title: 'Crear tarea',
              onCancel: () {
                Navigator.of(context).pop();
              },
              onSave: () {
                final todoDetail = ToDoDetailEntity(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  complete: false,
                  orderDetail: 0,
                  startDate: _selectedDate,
                  startTime: _selectedTime,
                );
                Navigator.of(context).pop(todoDetail);
              },
            ),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(8.0),
                physics: const BouncingScrollPhysics(),
                children: [
                  TextField(
                    controller: _titleController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      label: Text('Titulo'),
                      hintText: 'Título de la tarea',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      label: Text('Descripción'),
                      hintText: 'Descripción de la tarea',
                    ),
                  ),
                  const SizedBox(height: 15),
                  ListTile(
                    title: const Text('Fecha de inicio'),
                    trailing: Text(
                      compareDates(_selectedDate, DateTime.now())
                          ? 'Hoy'
                          : DateFormat('dd MMM yyyy', 'es').format(
                              _selectedDate,
                            ),
                    ),
                    onTap: () async {
                      final fecha = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2050, 12, 31),
                        locale: const Locale("es", "ES"),
                      );
                      if (fecha != null) {
                        setState(() {
                          _selectedDate = fecha;
                        });
                      }
                    },
                  ),
                  ListTile(
                    title: const Text('Hora de inicio'),
                    trailing: Text(
                      '${_selectedTime.hour.toString().padLeft(2, '0')}: ${_selectedTime.minute.toString().padLeft(2, '0')}',
                    ),
                    onTap: () async {
                      final hora = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                      );
                      if (hora != null) {
                        setState(() {
                          _selectedTime = hora;
                        });
                      }
                    },
                  ),
                  const Wrap(
                    children: [
                      Chip(
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add_circle_outline_sharp),
                            Text('Agregar etiquetas'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
