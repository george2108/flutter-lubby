import 'package:flutter/material.dart';
import 'package:lubby_app/src/core/enums/repeat_type_enum.dart';

import '../../core/models/repeat_time_model.dart';

class RepeatWidget extends StatefulWidget {
  final RepeatTimeModel? data;

  const RepeatWidget({super.key, this.data});

  @override
  State<RepeatWidget> createState() => _RepeatWidgetState();
}

class _RepeatWidgetState extends State<RepeatWidget> {
  RepeatType repeatType = RepeatType.none;

  // configuracion semanal
  List<dynamic> daysOfWeek = [
    {'day': 'Lunes', 'selected': false},
    {'day': 'Martes', 'selected': false},
    {'day': 'Miercoles', 'selected': false},
    {'day': 'Jueves', 'selected': false},
    {'day': 'Viernes', 'selected': false},
    {'day': 'Sabado', 'selected': false},
    {'day': 'Domingo', 'selected': false},
  ];

  // configuracion mensual
  bool useDayOfStartDate = true;
  int dayOfMonth = 1;

  bool get validateButton {
    if (repeatType == RepeatType.none) {
      return true;
    } else if (repeatType == RepeatType.weekly) {
      return daysOfWeek.any((element) => element['selected'] == true);
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      repeatType = widget.data!.repeatType;

      if (widget.data != null && widget.data?.daysOfWeek != null) {
        final days = widget.data!.daysOfWeek!.split(',');
        daysOfWeek = daysOfWeek.map((e) {
          if (days.contains(e['day'])) {
            return {'day': e['day'], 'selected': true};
          } else {
            return e;
          }
        }).toList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Repetir'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: !validateButton
              ? null
              : () {
                  final repeatTimeModel = RepeatTimeModel(
                    repeatType: repeatType,
                    daysOfWeek: daysOfWeek
                        .where((element) => element['selected'] == true)
                        .map((e) => e['day'])
                        .join(',')
                        .toString(),
                  );
                  Navigator.of(context).pop(repeatTimeModel);
                },
          child: const Text('Aceptar'),
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          children: [
            _ContainerRepeat(
              child: _none(),
            ),
            const SizedBox(height: 10.0),
            _ContainerRepeat(
              child: _daily(),
            ),
            const SizedBox(height: 10.0),
            _ContainerRepeat(
              child: _weekly(context),
            ),
            const SizedBox(height: 10.0),
            // mostrar dias de la semana seleccionables en caso de que sea semanal
            _ContainerRepeat(
              child: _monthly(),
            ),
            const SizedBox(height: 10.0),
            _ContainerRepeat(
              child: _yearly(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _none() {
    return ListTile(
      title: const Text('No repetir'),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      onTap: () {
        setState(() {
          repeatType = RepeatType.none;
        });
      },
      leading: Radio(
        value: RepeatType.none,
        groupValue: repeatType,
        onChanged: (value) {
          setState(() {
            repeatType = value as RepeatType;
          });
        },
      ),
    );
  }

  Widget _daily() {
    return ListTile(
      title: const Text('Diario'),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      onTap: () {
        setState(() {
          repeatType = RepeatType.daily;
        });
      },
      leading: Radio(
        value: RepeatType.daily,
        groupValue: repeatType,
        onChanged: (value) {
          setState(() {
            repeatType = value as RepeatType;
          });
        },
      ),
    );
  }

  Widget _yearly() {
    return ListTile(
      title: const Text('Anual'),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      onTap: () {
        setState(() {
          repeatType = RepeatType.yearly;
        });
      },
      leading: Radio(
        value: RepeatType.yearly,
        groupValue: repeatType,
        onChanged: (value) {
          setState(() {
            repeatType = value as RepeatType;
          });
        },
      ),
    );
  }

  Widget _monthly() {
    return Column(
      children: [
        ListTile(
          title: const Text('Mensual'),
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          onTap: () {
            setState(() {
              repeatType = RepeatType.monthly;
            });
          },
          leading: Radio(
            value: RepeatType.monthly,
            groupValue: repeatType,
            onChanged: (value) {
              setState(() {
                repeatType = value as RepeatType;
              });
            },
          ),
        ),
        // usar la fecha seleccionada en el calendario
        if (repeatType == RepeatType.monthly)
          Row(
            children: [
              Checkbox(
                value: useDayOfStartDate,
                onChanged: (value) {
                  setState(() {
                    useDayOfStartDate = value!;
                  });
                },
              ),
              const Text(
                'Usar la fecha de la fecha inicial',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(width: 10.0),
            ],
          ),
        if (repeatType == RepeatType.monthly)
          Row(
            children: [
              const SizedBox(width: 10.0),
              const Text('Dia del mes:'),
              const SizedBox(width: 10.0),
              DropdownButton(
                value: dayOfMonth,
                items: List.generate(
                  31,
                  (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text('${index + 1}'),
                  ),
                ),
                onChanged: useDayOfStartDate
                    ? null
                    : (value) {
                        setState(() {
                          dayOfMonth = value as int;
                        });
                      },
              ),
            ],
          ),
      ],
    );
  }

  Widget _weekly(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Semanal'),
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
          onTap: () {
            setState(() {
              repeatType = RepeatType.weekly;
            });
          },
          leading: Radio(
            value: RepeatType.weekly,
            groupValue: repeatType,
            onChanged: (value) {
              setState(() {
                repeatType = value as RepeatType;
              });
            },
          ),
        ),
        if (repeatType == RepeatType.weekly)
          Wrap(
            children: daysOfWeek
                .map(
                  (day) => GestureDetector(
                    onTap: () {
                      setState(() {
                        day['selected'] = !day['selected'];
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: day['selected']
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        border: Border.all(
                          color: Theme.of(context).highlightColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        day['day'],
                        style: TextStyle(
                          color: day['selected']
                              ? Colors.white
                              : Theme.of(context).highlightColor,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

class _ContainerRepeat extends StatelessWidget {
  final Widget child;

  const _ContainerRepeat({required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Theme.of(context).highlightColor,
          width: 2,
        ),
      ),
      child: child,
    );
  }
}
