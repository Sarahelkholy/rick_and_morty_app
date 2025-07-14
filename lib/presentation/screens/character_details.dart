import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../data/models/characters.dart';

class CharacterDetails extends StatelessWidget {
  final Result character;
  const CharacterDetails({super.key, required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.kGreen,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name,
          style: const TextStyle(
              color: MyColors.kWhite, fontWeight: FontWeight.bold),
        ),
        background: Hero(
            tag: character.id,
            child: Image.network(
              character.image,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
                color: MyColors.kWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(color: MyColors.kWhite, fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.kGreen,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.kGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      characterInfo('Species : ', character.species.name),
                      buildDivider(250),
                      characterInfo('Gender : ', character.gender.name),
                      buildDivider(260),
                      characterInfo(
                          'Created  : ', character.created.year.toString()),
                      buildDivider(250),
                      characterInfo('Location : ', character.location.name),
                      buildDivider(248),
                      characterInfo('Status : ', character.status.name),
                      buildDivider(265),
                      character.type.isEmpty
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                characterInfo('Type : ', character.type),
                                buildDivider(250),
                              ],
                            ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
