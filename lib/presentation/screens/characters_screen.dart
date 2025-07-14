import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/colors.dart';
import '../../data/models/characters.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Result> allcharacters;
  late List<Result> searchedForCharacters;
  bool _isSearched = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.kWhite,
      decoration: const InputDecoration(
          hintText: 'Find a character.....',
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColors.kWhite, fontSize: 18)),
      style: const TextStyle(color: MyColors.kWhite, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedFotItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedFotItemsToSearchedList(String searchedCharater) {
    searchedForCharacters = allcharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharater))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBArActions() {
    if (_isSearched) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: MyColors.kWhite,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearching,
            icon: const Icon(
              Icons.search,
              color: MyColors.kWhite,
            ))
      ];
    }
  }

  void _startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearched = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearched = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allcharacters = (state).characters;
        return buildLoadedListWidget();
      } else {
        return showLoadingIndecator();
      }
    });
  }

  Widget showLoadingIndecator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.kGreen,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.kGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty
            ? allcharacters.length
            : searchedForCharacters.length,
        itemBuilder: (context, index) {
          return CharacterItem(
            character: _searchTextController.text.isEmpty
                ? allcharacters[index]
                : searchedForCharacters[index],
          );
        });
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColors.kWhite),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Can\'t connect .. check internet',
              style: TextStyle(color: MyColors.kGreen, fontSize: 22),
            ),
            Image.asset('assets/images/error.png')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.kGreen,
        title: _isSearched ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBArActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          List<ConnectivityResult> connectivity,
          Widget child,
        ) {
          final bool connected =
              !connectivity.contains(ConnectivityResult.none);
          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndecator(),
      ),
    );
  }
}
