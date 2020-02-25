import 'package:background_location/background_location.dart';
import 'package:bratur/features/map_page/person_map_marker.dart';
import 'package:bratur/models/user.dart';
import 'package:bratur/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:user_location/user_location.dart';

class MapPage extends StatefulWidget {
  final bool isSharingLocation;
  final Function onShareLocationTapped;
  final String tripId;
  final List<User> users;
  final GlobalKey<ScaffoldState> scaffoldKey;

  MapPage({
    @required this.isSharingLocation,
    @required this.onShareLocationTapped,
    @required this.tripId,
    @required this.users,
    @required this.scaffoldKey,
  });

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final markers = widget.users.map((user) {
      return Marker(
        point: LatLng(
          user.currentLocation.latitude,
          user.currentLocation.longitude,
        ),
        anchorPos: AnchorPos.align(AnchorAlign.center),
        builder: (ctx) => PersonMapMarker(
          key: Key(user.userId),
          user: user,
        ),
      );
    }).toList();

    return Scaffold(
      key: widget.scaffoldKey,
      body: FutureBuilder(
        future: BackgroundLocation.checkPermissions(),
        initialData: PermissionStatus.unknown,
        builder: (context, AsyncSnapshot<PermissionStatus> permissionsStatus) {
          return FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(58.9177924, 5.7020611),
              zoom: 12,
              plugins: [
                UserLocationPlugin(),
              ],
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://api.tiles.mapbox.com/v4/"
                    "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                additionalOptions: {
                  'accessToken': mapboxAccessToken,
                  'id': 'mapbox.streets',
                },
              ),
              MarkerLayerOptions(markers: markers),
              if (permissionsStatus.data.value ==
                  PermissionStatus.granted.value)
                UserLocationOptions(
                  context: context,
                  mapController: _mapController,
                  markers: markers,
                  updateMapLocationOnPositionChange: false,
                  zoomToCurrentLocationOnLoad: false,
                  moveToCurrentLocationFloatingActionButton:
                      FloatingActionButton(
                    child: Icon(Icons.my_location),
                    onPressed: null,
                  ),
                  fabHeight: 48,
                  fabWidth: 48,
                  fabBottom: 16,
                  fabRight: 16,
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => widget.onShareLocationTapped(),
        icon: Icon(Icons.track_changes),
        label: Text(
            widget.isSharingLocation ? 'Stop sharing' : 'Share my location'),
        backgroundColor: widget.isSharingLocation
            ? Theme.of(context).buttonColor
            : Theme.of(context).accentColor,
        foregroundColor: widget.isSharingLocation
            ? Theme.of(context).textTheme.button.color
            : Theme.of(context).accentTextTheme.button.color,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
