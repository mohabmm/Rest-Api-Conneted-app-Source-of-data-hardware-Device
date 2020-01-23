import 'package:ahmedapp/core/enums/viewstate.dart';
import 'package:ahmedapp/core/models/user.dart';
import 'package:ahmedapp/core/viewmodels/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'base_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
        model: HomeViewModel(),
        onModelReady: (model) => model.getHomeData(),
        builder: (
          context,
          model,
          child,
        ) =>
            Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                body: _getBodyUi(context, model)));
  }

  Widget _getLoadingUi(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
        Text('Fetching data ...')
      ],
    ));
  }

  Widget _noDataUi(BuildContext context, HomeViewModel model) {
    return _getCenteredViewMessage(context, "No data available yet", model);
  }

  Widget _errorUi(BuildContext context, HomeViewModel model) {
    return _getCenteredViewMessage(
        context, "Error retrieving your data. Tap to try again", model,
        error: true);
  }

  Widget _getCenteredViewMessage(
      BuildContext context, String message, HomeViewModel model,
      {bool error = false}) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
                error
                    ? Icon(
                        // Wrap in gesture detector and call you refresh future here
                        Icons.refresh,
                        color: Colors.white,
                        size: 45.0,
                      )
                    : Container()
              ],
            )));
  }

  Widget _getBodyUi(BuildContext context, HomeViewModel model) {
    print("get body UI OF THE HOME VIEW ");
    switch (model.state) {
      case ViewState.Busy:
        return _getLoadingUi(context);
      case ViewState.NoDataAvailable:
        return _noDataUi(context, model);
      case ViewState.Error:
        return _errorUi(context, model);
      case ViewState.DataFetched:
      default:
        return _getListUi(model, context);
    }
  }

  Widget _getListUi(HomeViewModel model, BuildContext context) {
//    String userId = Provider.of<User>(context).id;
    return Center(
      child: Scaffold(
        appBar: AppBar(title: new Text('Main Data')),
        body: Center(
          child: new ListView.builder(
              itemExtent: 220.0,
              itemCount: model.mainGarages.length,
              itemBuilder: (BuildContext context, int index) {
                String name = model.mainGarages[index].name;
                String areaId = model.mainGarages[index].id;

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'areaId', arguments: areaId);
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Container(
                        child: Material(
                          color: Colors.white,
                          elevation: 14.0,
                          borderRadius: BorderRadius.circular(22.0),
                          shadowColor: Color(0x802196F3),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Expanded(
                                child: Container(
                                    child: new Container(
                                  child: new Column(
//                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      ListTile(
                                        subtitle: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0.0),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0.0),
                                                  child: Center(
                                                    child: new Text(
                                                      name,
                                                      style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 23.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

//
