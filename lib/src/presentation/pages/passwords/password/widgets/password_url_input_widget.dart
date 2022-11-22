part of '../password_page.dart';

class PasswordURLInputWidget extends StatelessWidget {
  const PasswordURLInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<PasswordBloc>().state.urlController,
      maxLines: 1,
      maxLength: 1500,
      keyboardType: TextInputType.url,
      decoration: const InputDecoration(
        counterText: '',
        hintText: "URL del sitio web",
        labelText: 'URL sitio web',
      ),
    );
  }
}
