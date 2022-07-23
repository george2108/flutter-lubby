part of '../password_page.dart';

class PasswordFavoriteWidget extends StatelessWidget {
  const PasswordFavoriteWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordBloc, PasswordState>(
      builder: (context, state) {
        if (state is PasswordLoadedState) {
          return IconButton(
            icon: Icon(
              state.favorite ? Icons.star : Icons.star_border_outlined,
            ),
            onPressed: () {
              context.read<PasswordBloc>().add(PasswordMarkedFavorite());
            },
          );
        }

        return Container();
      },
    );
  }
}
