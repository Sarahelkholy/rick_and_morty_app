import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../data/models/characters.dart';

class CharacterItem extends StatelessWidget {
  final Result character;
  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
          color: MyColors.kWhite, borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, characterDetailsScreen,
            arguments: character),
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              character.name,
              style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.kWhite,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          child: Hero(
            tag: character.id,
            child: Container(
              color: MyColors.kGrey,
              child: character.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/Loading.gif',
                      image: character.image,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/placeholder.png'),
            ),
          ),
        ),
      ),
    );
  }
}
