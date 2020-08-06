import 'package:flutter/material.dart';
import 'package:sprout_app/blocs/biologs_manager.dart';
import 'package:sprout_app/blocs/provider.dart';
import 'package:sprout_app/models/biologs.dart';
import 'package:sprout_app/models/login_details.dart';
import 'package:sprout_app/services/sprout_scraper_api.dart';

class ResponseScreen extends StatefulWidget {
  final LoginDetails details;
  final bool isRequested;

  ResponseScreen({Key key, this.details, this.isRequested}) : super(key: key);

  @override
  _ResponseScreenState createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  @override
  Widget build(BuildContext context) {
    BiologsManager manager = Provider.of(context).fetch(BiologsManager);
    Size size = MediaQuery.of(context).size;

    if (!widget.isRequested) {
      manager.initFromCache();
    }

    return WillPopScope(
      onWillPop: () async {
        manager.request.add(null);
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(manager, context),
        body: SafeArea(
          child: StreamBuilder<Biologs>(
            stream: manager.response,
            builder: (BuildContext context, AsyncSnapshot<Biologs> snapshot) {
              if (snapshot.hasData) {
                Biologs biologs = snapshot.data;
                return _onSuccess(context, biologs);
              } else if (snapshot.hasError) {
                return _onError(size, snapshot, context);
              } else {
                return _onWaiting();
              }
            },
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BiologsManager manager, BuildContext context) {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          manager.request.add(null);
          Navigator.of(context).pop();
        },
      ),
      title: const Text('Back to Main'),
      actions: <Widget>[
        if (!widget.isRequested)
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () {
              manager.request.add(null);
              getBiologs(widget.details)
                  .then((value) => manager.request.add(value))
                  .catchError((error) => manager.request.addError(error));
            },
          )
      ],
    );
  }

  Widget _onSuccess(BuildContext context, Biologs biologs) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "TIME IN",
                  style: Theme.of(context).textTheme.subtitle2.apply(
                      color: Theme.of(context).primaryColor,
                      fontWeightDelta: 1),
                ),
              ),
              Text(
                biologs.timein ?? "No data yet!",
                style: Theme.of(context).textTheme.headline6.apply(
                    color: biologs.timein != null
                        ? Colors.black87
                        : Colors.black26),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "TIME OUT",
                  style: Theme.of(context).textTheme.subtitle2.apply(
                      color: Theme.of(context).primaryColor,
                      fontWeightDelta: 1),
                ),
              ),
              Text(
                biologs.timeout ?? "No data yet!",
                style: Theme.of(context).textTheme.headline6.apply(
                    color: biologs.timeout != null
                        ? Colors.black87
                        : Colors.black26),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "DURATION",
                  style: Theme.of(context).textTheme.subtitle2.apply(
                      color: Theme.of(context).primaryColor,
                      fontWeightDelta: 1),
                ),
              ),
              Text(
                biologs.timediff ?? "No data yet!",
                style: Theme.of(context).textTheme.headline6.apply(
                    color: biologs.timediff != null
                        ? Colors.black87
                        : Colors.black26),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "LAST UPDATED",
                  style: Theme.of(context).textTheme.subtitle2.apply(
                      color: Theme.of(context).primaryColor,
                      fontWeightDelta: 1),
                ),
              ),
              Text(
                biologs.lastupdated ?? "No data yet!",
                style: Theme.of(context).textTheme.headline6.apply(
                    color: biologs.lastupdated != null
                        ? Colors.black87
                        : Colors.black26),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _onError(
      Size size, AsyncSnapshot<Biologs> snapshot, BuildContext context) {
    return Center(
      child: Container(
        width: size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error_outline,
              size: 30,
              color: Colors.red[800],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${snapshot.error}",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .apply(color: Colors.red[800]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _onWaiting() => LinearProgressIndicator();
}
