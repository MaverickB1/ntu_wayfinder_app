import 'package:flutter/material.dart';
import '../model/nav_route.dart';

class SearchBarCopy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29.5),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Click on Search Icon to Start',
          icon: IconButton(
            onPressed: () {
              showSearch(context: context, delegate: StudentSearch());
            },
            icon: const Icon(Icons.search),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class StudentSearch extends SearchDelegate<NavRoute> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.navigate_before),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listItems = query.isEmpty
        ? navRoutes
        : navRoutes
            .where((element) => element.start
                .toLowerCase()
                .startsWith(query.toLowerCase().toString()))
            .toList();

    return listItems.isEmpty
        ? const Center(child: Text('No Data Found!'))
        : ListView.builder(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.person,
                          size: 40,
                        ),
                        title: Text(
                            '${listItems[index].start} to ${listItems[index].destination}'),
                        subtitle: Text(
                            'Step #${listItems[index].destination.toString()}'),
                        onTap: () {
                          showResults(context);
                        },
                      ),
                      const Divider(),
                    ],
                  ));
            });
  }
}
