import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:schedulemanager/api/map_api.dart';
import 'package:schedulemanager/screens/map_page/map_page.dart';
import 'package:schedulemanager/widgets/animated_marker.dart';
import '../constants/constants.dart';
import '../services/base_service.dart';

class MapPreview extends StatefulWidget {
  final void Function(LatLng start, String? startAddress, LatLng end,
      String? endAddress, List<LatLng>? points)? onAcceptCallback;
  final double height;
  final double width;
  final GeoPoint initialPoint;
  final GeoPoint endPoint;
  final String? startAddress;
  final String? endAddress;

  const MapPreview({
    super.key,
    required this.height,
    required this.width,
    required this.initialPoint,
    required this.endPoint,
    required this.onAcceptCallback,
    this.startAddress,
    this.endAddress,
  });

  @override
  State<MapPreview> createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  late MapController _controller;
  late List<LatLng> _points;
  @override
  void initState() {
    super.initState();
    _controller = MapController();
    _points = [];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print('updating');
      try {
        final start =
            LatLng(widget.initialPoint.latitude, widget.initialPoint.longitude);
        final end = LatLng(widget.endPoint.latitude, widget.endPoint.longitude);
        final points = await MapApi().getPolyline(start, end);
        if (points != null) {
          setState(() {
            _points = points;
          });
        }
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LatLng startlPos =
        LatLng(widget.initialPoint.latitude, widget.initialPoint.longitude);
    final LatLng endPos =
        LatLng(widget.endPoint.latitude, widget.endPoint.longitude);
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        _controller.fitBounds(
          LatLngBounds(startlPos, endPos),
          options: const FitBoundsOptions(
            padding: EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 30,
            ),
          ),
        );
      },
    );

    return GestureDetector(
      child: Container(
        height: widget.height,
        width: widget.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: lightGrey.withOpacity(0.25),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FlutterMap(
            mapController: _controller,
            options: MapOptions(
              interactiveFlags: InteractiveFlag.none,
              enableMultiFingerGestureRace: false,
              keepAlive: false,
              // minZoom: 13,
              maxZoom: 15,
              zoom: 10,
              minZoom: 1,
              onTap: (tapPosition, point) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return MapPage(
                      startPos: startlPos,
                      endPost: endPos,
                      startAddress: widget.startAddress,
                      endAddress: widget.endAddress,
                      onAcceptCallback:
                          (start, startAddress, end, endAddress, points) {
                        setState(() {
                          _points = points!;
                        });
                        if (widget.onAcceptCallback != null) {
                          widget.onAcceptCallback!(
                              start, startAddress, end, endAddress, points);
                        }
                      },
                    );
                  },
                ));
              },
              center: LatLng(
                widget.initialPoint.latitude,
                widget.initialPoint.longitude,
              ),
            ),
            children: [
              TileLayer(
                backgroundColor: Colors.white,
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/frankrdz/{styleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                additionalOptions: {
                  'styleId': 'clarc1scl000314lfyzx582dm',
                  'accessToken': dotenv.env['MAPBOX_ACCESSTOKEN']!,
                },
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    color: accent.withOpacity(0.8),
                    borderColor: accent.withOpacity(0.8),
                    borderStrokeWidth: 5,
                    strokeCap: StrokeCap.round,
                    points: _points,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [widget.initialPoint, widget.endPoint]
                    .map(
                      (e) => Marker(
                        point: LatLng(e.latitude, e.longitude),
                        builder: (context) {
                          return const AnimatedMarker();
                        },
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
