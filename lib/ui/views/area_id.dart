import 'package:ahmedapp/core/enums/viewstate.dart';
import 'package:ahmedapp/core/viewmodels/area_id_ViewModel.dart';
import 'package:ahmedapp/core/viewmodels/home_view_model.dart';
import 'package:ahmedapp/ui/utilities/show_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'base_widget.dart';

class AreaId extends StatelessWidget {
  final String id;
  AreaId(this.id);
  @override
  Widget build(BuildContext context) {
    return BaseWidget<AreaIdViewModel>(
        model: AreaIdViewModel(),
        onModelReady: (model) => model.getAreaData(id),
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

  Widget _noDataUi(BuildContext context, AreaIdViewModel model) {
    return _getCenteredViewMessage(context, "No data available yet", model);
  }

  Widget _errorUi(BuildContext context, AreaIdViewModel model) {
    return _getCenteredViewMessage(
        context, "Error retrieving your data. Tap to try again", model,
        error: true);
  }

  Widget _getCenteredViewMessage(
      BuildContext context, String message, AreaIdViewModel model,
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

  Widget _getBodyUi(BuildContext context, AreaIdViewModel model) {
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

  Widget _getListUi(AreaIdViewModel model, BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(title: new Text('area Data')),
        body: Center(
          child: new ListView.builder(
              itemExtent: 220.0,
              itemCount: model.areaData.length,
              itemBuilder: (BuildContext context, int index) {
                String name = model.areaData[index].name;
                String areaId = model.areaData[index].id;

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'garageId', arguments: areaId);
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
                                    mainAxisSize: MainAxisSize.min,
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
