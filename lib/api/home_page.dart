import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/api/api_helper.dart';
import 'package:project/api/bloc/quots_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<QuotsBloc>(context).add(GetQuotesEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Quotes"),
        ),
        body: BlocBuilder<QuotsBloc, QuotsState>(builder: (context, state) {
          if (state is QuotsLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is QuotsErrorState) {
            return Center(
              child: Text('${state.errorMessage}'),
            );
          } else if (state is QuotsLoadedState) {
            var mDataModel = state.quoteData;
            return ListView.builder(
                itemBuilder: (_, index) {
                  var eachQuote = mDataModel.quotes![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 7,
                      child: ListTile(
                        title: Text(eachQuote.quote.toString()),
                        subtitle: Text(eachQuote.author.toString()),
                      ),
                    ),
                  );
                },
                itemCount: mDataModel.quotes!.length);
          }
          return Container();
        }));
  }
}
