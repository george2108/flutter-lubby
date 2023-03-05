part of '../diary_main_page.dart';

class ResumeView extends StatelessWidget {
  const ResumeView({super.key});

  @override
  Widget build(BuildContext context) {
    final diaryBloc = BlocProvider.of<DiaryBloc>(context);
    final diaryBlocListening = BlocProvider.of<DiaryBloc>(
      context,
      listen: true,
    );

    return Column(
      children: [
        DatePickerRow(
          DateTime.now().subtract(const Duration(
            days: 50,
          )),
          initialSelectedDate: DateTime.now(),
          daysCount: 100,
          locale: 'es_ES',
          onDateChange: (date) {
            diaryBloc.add(GetDiariesResumeEvent(date));
          },
        ),
        Expanded(
          child: diaryBlocListening.state.diariesOneDate.isEmpty
              ? const Center(
                  child: Text('No hay eventos en esta fecha'),
                )
              : const SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 100),
                  child: _TimeLineEvents(),
                ),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
///
/// Widget encargado de mostrar los eventos en el tiempo
///
////////////////////////////////////////////////////////////////////////////////

class _TimeLineEvents extends StatelessWidget {
  const _TimeLineEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final diaryBloc = BlocProvider.of<DiaryBloc>(
      context,
      listen: true,
    );

    return Timeline(
      physics: const ClampingScrollPhysics(),
      itemGap: 30,
      lineGap: 0,
      indicators: diaryBloc.state.diariesOneDate.isEmpty
          ? []
          : diaryBloc.state.diariesOneDate.map(
              (diary) {
                return Container(
                  decoration: BoxDecoration(
                    color: diary.color,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.timer_sharp),
                );
              },
            ).toList(),
      children: diaryBloc.state.diariesOneDate.isEmpty
          ? []
          : diaryBloc.state.diariesOneDate.map(
              (diary) {
                return _EventInfo(diary: diary);
              },
            ).toList(),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
///
/// Widget encargado de mostrar la información de un evento
///
////////////////////////////////////////////////////////////////////////////////

class _EventInfo extends StatelessWidget {
  final DiaryEntity diary;

  const _EventInfo({
    Key? key,
    required this.diary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            diary.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          if (diary.description != null) Text(diary.description ?? ''),
          if (diary.description != null) const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.watch_later_outlined),
              const SizedBox(width: 5),
              Row(
                children: [
                  Text(
                    diary.startTime != null
                        ? '${diary.startTime?.hour.toString().padLeft(2, '0')}:${diary.startTime?.minute.toString().padLeft(2, '0')}'
                        : 'Todo el día',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (diary.endTime != null) const Text(' - '),
                  if (diary.endTime != null)
                    Text(
                      '${diary.endTime?.hour.toString().padLeft(2, '0')}:${diary.endTime?.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
