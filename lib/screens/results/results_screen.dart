import 'package:flutter/material.dart';

import '../../models/result_model.dart';

class RecentResultsScreen extends StatefulWidget {
  const RecentResultsScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/resultsscreen';

  @override
  State<RecentResultsScreen> createState() => _RecentResultsScreenState();
}

class _RecentResultsScreenState extends State<RecentResultsScreen> {
  List<ResultModel> result = [];

  @override
  void initState() {
    result = List.of(results);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              'Recent',
              textAlign: TextAlign.left,
              textScaleFactor: 1.5,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Text(
              'Results',
              textAlign: TextAlign.left,
              textScaleFactor: 1.5,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.builder(
              shrinkWrap: true,
              itemCount: result.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (context, index) {
                final recentResults = result[index];
                return resultsGrid(recentResults);
              })
        ],
      ),
    ));
  }

  Widget resultsGrid(ResultModel result) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(result.foodPicURL),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(result.dateChecked),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      );
}
