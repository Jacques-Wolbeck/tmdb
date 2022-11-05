import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tmdb/android/widgets/commons/app_rich_text.dart';
import 'package:tmdb/shared/models/movie_model.dart';

import 'commons/app_progress_indicator.dart';

class BottomSheetContent extends StatelessWidget {
  final MovieModel movie;
  const BottomSheetContent({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            thickness: 4.0,
            indent: MediaQuery.of(context).size.width * 0.4,
            endIndent: MediaQuery.of(context).size.width * 0.4,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 8.0),
          _bottomSheetContent()
        ],
      ),
    );
  }

  Widget _bottomSheetContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w220_and_h330_face${movie.poster}',
                  height: 200,
                  width: 150,
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
              ),
              const SizedBox(width: 16.0),
              _movieInformation(),
            ],
          ),
          const SizedBox(height: 8.0),
          AppRichText(
              text1: 'Overview: ',
              text2: (movie.overview != null && movie.overview != '')
                  ? movie.overview!
                  : 'Sem overview')
        ],
      ),
    );
  }

  Widget _movieInformation() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.originalTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          AppRichText(
              text1: 'Genêro: ',
              text2:
                  movie.genres.toString().replaceAll(RegExp('[\\[\\]]'), '')),
          AppRichText(
              text1: 'Data de Lançamento: ',
              text2: _formatData(movie.releaseDate)),
          AppRichText(text1: 'Idioma: ', text2: movie.originalLanguage)
        ],
      ),
    );
  }

  String _formatData(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
