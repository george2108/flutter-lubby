part of '../diary_main_page.dart';

class ResumePageItemWidget extends StatelessWidget {
  const ResumePageItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Hoy 06 Dic. 2022',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Timeline(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          indicators: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_outlined),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.timer_sharp),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.calendar_month_outlined),
            ),
          ],
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Nombre del evento'),
                  Text('descripcion del evento'),
                  Text('12:36'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('evento'),
                  Text('descripcion del evento'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '(Próximo evento)',
                    style: TextStyle(fontSize: 10, color: Colors.yellow),
                  ),
                  Text('evento'),
                  Text('descripcion del evento'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
