import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lubby_app/src/core/models/repeat_time_model.dart';
import 'package:lubby_app/src/ui/widgets/checkbox_widget.dart';
import 'package:lubby_app/src/ui/widgets/header_modal_bottom_widget.dart';
import 'package:lubby_app/src/ui/widgets/repeat_widget.dart';

import '../../../../core/enums/repeat_type_enum.dart';
import '../../../../data/entities/diary_entity.dart';
import '../../../widgets/checkbox_lottie_widget.dart';

class AddNewEventWidget extends StatefulWidget {
  const AddNewEventWidget({super.key});
  @override
  State<AddNewEventWidget> createState() => _AddNewEventWidgetState();
}

class _AddNewEventWidgetState extends State<AddNewEventWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime startDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  DateTime endDate = DateTime.now();
  TimeOfDay endTime = TimeOfDay.fromDateTime(DateTime.now().add(
    const Duration(hours: 1),
  ));

  bool eventAllDay = false;
  bool eventOneDay = false;

  RepeatTimeModel repeatTime = const RepeatTimeModel(
    repeatType: RepeatType.none,
    daysOfWeek: null,
  );

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, scrollController) => Column(
        children: [
          HeaderModalBottomWidget(
            title: 'Nuevo evento',
            onCancel: () {
              Navigator.pop(context);
            },
            onSave: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              final diary = DiaryEntity(
                title: _titleController.text,
                description: _descriptionController.text,
                startDate: startDate,
                endDate: !eventOneDay ? endDate : null,
                startTime: !eventAllDay ? startTime : null,
                endTime: !eventAllDay || !eventAllDay ? endTime : null,
                color: Colors.blue,
                typeRepeat: repeatTime.repeatType.name,
                daysRepeat: repeatTime.daysOfWeek.toString(),
              );
              Navigator.of(context).pop(diary);
            },
          ),
          Expanded(
            child: _body(scrollController, context),
          ),
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  ///                                                                        ///
  /// Widget que contiene el cuerpo del formulario                           ///
  ///                                                                        ///
  //////////////////////////////////////////////////////////////////////////////
  Widget _body(ScrollController scrollController, BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(12),
          children: [
            TextFormField(
              controller: _titleController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Nombre del evento',
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'El nombre del evento no puede estar vacio';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: 'Descripción del evento',
              ),
            ),
            const SizedBox(height: 12),
            const Divider(),
            Row(
              children: [
                CheckboxLottieWidget(
                  value: eventOneDay,
                  onChanged: (value) {
                    setState(() {
                      eventOneDay = value;
                    });
                  },
                ),
                const SizedBox(width: 5),
                const Expanded(
                  child: Text('El evento dura solo un día'),
                ),
              ],
            ),
            Row(
              children: [
                CheckboxLottieWidget(
                  value: eventAllDay,
                  onChanged: (value) {
                    setState(() {
                      eventAllDay = value;
                    });
                  },
                ),
                const SizedBox(width: 5),
                const Text('El evento es todo el día'),
              ],
            ),
            const SizedBox(height: 12),
            // fecha y hora de inicio
            _start(context),
            const SizedBox(height: 12),
            // fecha y hora de fin
            if (!eventOneDay) _end(context),
            const SizedBox(height: 12),
            // Widget encargado de mostrar el dialogo para configurar la repeticion del evento
            _repeat(context),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Etiquetas',
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Recordatorio',
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  ///                                                                        ///
  /// Widget que contiene la repeticion del evento                           ///
  ///                                                                        ///
  //////////////////////////////////////////////////////////////////////////////
  Widget _repeat(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final RepeatTimeModel? repeatTimeDateResponse = await showDialog(
          context: context,
          builder: (context) {
            return const RepeatWidget();
          },
        );

        if (repeatTimeDateResponse != null) {
          setState(() {
            repeatTime = repeatTime.copyWith(
              repeatType: repeatTimeDateResponse.repeatType,
              daysOfWeek: repeatTimeDateResponse.daysOfWeek,
            );
          });
        }
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).highlightColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: showWidgetRepeatType,
      ),
    );
  }

  Widget get showWidgetRepeatType {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.primary,
    );
    switch (repeatTime.repeatType) {
      case RepeatType.none:
        return Text('No repetir', style: style);
      case RepeatType.daily:
        return Text('Repetir diariamente', style: style);
      case RepeatType.weekly:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Repetir Semanalmente', style: style),
            const SizedBox(height: 5),
            Wrap(
              spacing: 5,
              children: repeatTime.daysOfWeek!
                  .split(',')
                  .map(
                    (e) => Chip(
                      label: Text(e),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      case RepeatType.monthly:
        return Text('Repetir mensualmente', style: style);
      case RepeatType.yearly:
        return Text('Repetir anualmente', style: style);
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  ///                                                                        ///
  /// Widget que contiene la fecha y hora de fin del evento                  ///
  ///                                                                        ///
  //////////////////////////////////////////////////////////////////////////////
  Widget _end(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).highlightColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Fecha y hora de finalización'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(
                  DateFormat('dd/MM/yyyy').format(endDate),
                ),
                onPressed: () async {
                  final value = await showDatePicker(
                    context: context,
                    initialDate: endDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (value != null) {
                    setState(() {
                      endDate = value;
                    });
                  }
                },
              ),
              if (!eventAllDay)
                TextButton(
                  child: Text(endTime.format(context)),
                  onPressed: () async {
                    final value = await showTimePicker(
                      context: context,
                      initialTime: endTime,
                    );

                    if (value != null) {
                      setState(() {
                        endTime = value;
                      });
                    }
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  ///                                                                        ///
  /// Widget que contiene la fecha y hora de inicio del evento               ///
  ///                                                                        ///
  //////////////////////////////////////////////////////////////////////////////
  Widget _start(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).highlightColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Fecha y hora de inicio'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(
                  DateFormat('dd/MM/yyyy').format(startDate),
                ),
                onPressed: () async {
                  final value = await showDatePicker(
                    context: context,
                    initialDate: startDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (value != null) {
                    setState(() {
                      startDate = value;
                    });
                  }
                },
              ),
              if (!eventAllDay)
                TextButton(
                  child: Text(startTime.format(context)),
                  onPressed: () async {
                    final value = await showTimePicker(
                      context: context,
                      initialTime: startTime,
                    );

                    if (value != null) {
                      setState(() {
                        startTime = value;
                      });
                    }
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
