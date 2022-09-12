import 'package:flutter/material.dart';

class Anticipated extends StatelessWidget {
  const Anticipated({
    Key? key,
    required this.screenData,
  }) : super(
          key: key,
        );

  final screenData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: (.16 / .25),
        crossAxisCount: 2,
        mainAxisSpacing: 30,
      ),
      itemCount: screenData?.movieAnticipated.length,
      itemBuilder: (BuildContext ctx, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  'http://img.omdbapi.com/?apikey=956febbc&i=${screenData?.movieAnticipated[index].movie.ids.imdb}',
                  errorBuilder: (context, exception, stackTrace) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 108.0),
                      child: Center(
                          child: Icon(
                        Icons.not_interested_rounded,
                        size: 60,
                        color: Colors.white,
                      )),
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.star_border,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star_border,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star_border,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star_border,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star_border,
                    color: Colors.yellow,
                  ),
                ],
              ),
              Text(
                screenData?.movieAnticipated[index].movie.title ?? 'fa',
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Crime ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Icon(
                    Icons.circle,
                    size: 6,
                    color: Colors.grey,
                  ),
                  Text(
                    ' 2h 40m ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '| Rating',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
