import 'package:flutter/material.dart';
import 'package:tmdb/android/widgets/commons/app_card.dart';
import 'package:tmdb/android/widgets/commons/app_progress_indicator.dart';
import 'package:tmdb/android/widgets/fields/search_field.dart';
import 'package:tmdb/shared/models/movie_model.dart';
import 'package:tmdb/shared/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  final _listController = ScrollController();
  var allMovies = <MovieModel>[];
  int _page = 1;
  bool _isSearching = false;
  bool _hasData = true;
  bool _isLoading = true;

  @override
  void initState() {
    _searchController.addListener(() {
      setState(() {
        if (_searchController.text.isNotEmpty) {
          _isSearching = true;
        } else {
          _isSearching = false;
        }
      });
    });
    _listController.addListener(() {
      if (_listController.position.maxScrollExtent == _listController.offset &&
          !_isSearching) {
        if (!_isLoading) {
          setState(() {
            _page += 1;
            if (_page <= 100) {
              _getData();
            } else {
              _hasData = false;
            }
          });
        }
      }
    });
    _getData();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _listController.dispose();
    super.dispose();
  }

  void _getData() {
    ApiService.instance.getAllMovies(_page).then((movieList) {
      setState(() {
        allMovies.addAll(movieList);
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDb'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        SearchField(controller: _searchController),
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 200.0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onInverseSurface,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16.0),
                  topLeft: Radius.circular(16.0),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    //offset: const Offset(0, 0),
                    color: Theme.of(context).colorScheme.shadow,
                  )
                ],
              ),
              child: _moviesListView(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _moviesListView() {
    var movies = allMovies;
    if (_isLoading) {
      return const Center(
        child: AppProgressIndicator(),
      );
    }
    if (_searchController.text.isNotEmpty) {
      movies = _searchData(movies);
    }
    if (movies.isEmpty) {
      return const Center(
        child: Text('Nenhum filme encontrado'),
      );
    } else {
      return ListView.separated(
        controller: _listController,
        separatorBuilder: (context, __) => Divider(
          color: Theme.of(context).colorScheme.outline,
        ),
        itemCount: movies.length + 1,
        itemBuilder: (context, index) {
          if (index < movies.length) {
            final movie = movies[index];
            return AppCard(movie: movie);
          } else if (!_isSearching) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _hasData
                    ? const AppProgressIndicator()
                    : const Text('Fim da lista'),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );
    }
  }

  /*Widget _moviesListView() {
    return FutureBuilder(
      future: _futureData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          _isLoading = true;
          return const Center(
            child: AppProgressIndicator(),
          );
        }
        _isLoading = false;
        _allMovies.addAll(snapshot.data as List<MovieModel>);

        debugPrint('SetState');
        //
        debugPrint(' ALL MOVIES --------> ${_allMovies.length}');
        var movies = _allMovies;
        if (_searchController.text.isNotEmpty) {
          movies = _searchData(movies);
        }
        if (movies.isEmpty) {
          return const Center(
            child: Text('Nenhum filme encontrado'),
          );
        } else {
          return ListView.separated(
            controller: _listController,
            separatorBuilder: (context, __) => Divider(
              color: Theme.of(context).colorScheme.outline,
            ),
            itemCount: movies.length + 1,
            itemBuilder: (context, index) {
              if (index < movies.length) {
                final movie = movies[index];
                return AppCard(movie: movie);
              } else if (!_isSearching) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _hasData
                      ? const AppProgressIndicator()
                      : const Text('Fim da lista'),
                ));
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        }
      },
    );
  }*/

  List<MovieModel> _searchData(List<MovieModel> dataList) {
    final searchResult = <MovieModel>[];
    for (var data in dataList) {
      if (data.originalTitle
          .toLowerCase()
          .contains(_searchController.text.toLowerCase())) {
        searchResult.add(data);
      }
    }
    return searchResult;
  }
}
