import 'package:flutter/material.dart';

class NotesHelpView extends StatefulWidget {
  const NotesHelpView({Key? key}) : super(key: key);

  @override
  State<NotesHelpView> createState() => _NotesHelpViewState();
}

class _NotesHelpViewState extends State<NotesHelpView> {
  final List<Data> informacion = [
    Data(
      title: 'Primer contenido',
      content:
          'jfklsd flksdj flksdjf lksdjflksdjflk sdklfs jdlkfsdj lkfj sdlkfsldkf lksd flksdfj lksdjflkd ldkf jklfsd klfsdjlkfsd lkfsdklf lskdfjlskdjflksdjflk sdjfl ksdjflk sjdlk fjsdk lfjsldkfj lksdjflksdj flksdlfksjdlk fsldkf jslkd fj lksdjflk sdjflksdjflksdjf lsdlfksdfl ksdklf sdlk flksd flksd flksd flk',
      image:
          'https://www.pngmart.com/files/16/official-Google-Logo-PNG-Image.png',
    ),
    Data(
      title: 'segunda pagina de ayuda',
      content:
          'j fklsdjflksdjf klsdjflksdjflks dflksjlkfjdlskflksd fklsdflksdf',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/1/1e/RPC-JP_Logo.png',
    ),
    Data(
      title: 'tercera pagina de ayuda',
      content:
          'j fklsdjflksdjf klsdjflksdjflks dflksjlkfjdlskflksd fklsdflksdf',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/1/1e/RPC-JP_Logo.png',
    ),
  ];

  final PageController controller = PageController(initialPage: 0);

  int currentpage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: informacion.length,
              onPageChanged: (page) {
                currentpage = page;
                setState(() {});
              },
              itemBuilder: ((context, index) {
                return _DetailPage(data: informacion[index]);
              }),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: currentpage == 0
                      ? null
                      : () {
                          controller.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linearToEaseOut,
                          );
                        },
                  child: currentpage == 0
                      ? const Text('')
                      : const Text('< Anterior'),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      informacion.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 5),
                        width: currentpage == index ? 20 : 10,
                        height: currentpage == index ? 20 : 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentpage == index
                              ? Colors.blue
                              : Theme.of(context).colorScheme.background,
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: currentpage == informacion.length - 1
                      ? null
                      : () {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linearToEaseOut,
                          );
                        },
                  child: currentpage == informacion.length - 1
                      ? const Text('')
                      : const Text('Siguiente >'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailPage extends StatelessWidget {
  final Data data;

  const _DetailPage({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Image.network(data.image,
                loadingBuilder: ((_, child, loadingProgress) {
              if (loadingProgress != null) {
                return const CircularProgressIndicator();
              }
              return child;
            })),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 10),
                Text(data.content),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Data {
  final String title;
  final String content;
  final String image;

  Data({
    required this.title,
    required this.content,
    required this.image,
  });
}
