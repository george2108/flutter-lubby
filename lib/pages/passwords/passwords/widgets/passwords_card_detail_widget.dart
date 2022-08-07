part of '../passwords_page.dart';

class PasswordsCardDetailWidget extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String value;
  final String snackTitle;
  final String snackMessage;
  final bool copy;

  const PasswordsCardDetailWidget({
    Key? key,
    required this.context,
    required this.title,
    required this.value,
    required this.snackTitle,
    required this.snackMessage,
    this.copy = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Theme.of(context).textTheme.headline6!.fontSize,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    value,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (copy)
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    copyClipboardWidget(
                      value.toString(),
                      snackTitle,
                      snackMessage,
                      context,
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
