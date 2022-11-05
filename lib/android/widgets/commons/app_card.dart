import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tmdb/shared/models/movie_model.dart';

import '../bottom_sheet.dart';
import 'app_progress_indicator.dart';

class AppCard extends StatelessWidget {
  final MovieModel movie;
  const AppCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 140.0),
      child: Card(
        elevation: 2,
        child: Material(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                builder: (context) {
                  return BottomSheetContent(movie: movie);
                },
              );
            },
            child: _cardContent(context),
          ),
        ),
      ),
    );
  }

  Widget _cardContent(BuildContext context) {
    return Row(
      children: [
        movie.poster == null
            ? Container(
                height: 100.0,
                width: 80.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                ),
                child: Icon(
                  Icons.image,
                  size: 50,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              )
            : _dataImage(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.originalTitle,
                  style: const TextStyle(fontSize: 14.0),
                ),
                const SizedBox(height: 8.0),
                _subtitle(context, movie),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatData(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  _subtitle(BuildContext context, MovieModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Data de lançamento: ${_formatData(data.releaseDate)}",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        Text(
            'Gênero: ${movie.genres.toString().replaceAll(RegExp('[\\[\\]]'), '')}')
      ],
    );
  }

  Widget _dataImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8.0),
        bottomLeft: Radius.circular(8.0),
      ),
      child: Image.network(
        'https://image.tmdb.org/t/p/w220_and_h330_face${movie.poster}',
        height: 140,
        width: 90,
        fit: BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const SizedBox(
            width: 70.0,
            height: 70.0,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: AppProgressIndicator(),
            ),
          );
        },
        errorBuilder: ((context, error, stackTrace) {
          return const Icon(Icons.error);
        }),
      ),
    );
  }
}
