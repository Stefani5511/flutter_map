import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Obter Posição no Mapa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MapScreenOSM(),
    );
  }
}

class MapScreenOSM extends StatefulWidget {
  const MapScreenOSM({super.key});

  @override
  State<MapScreenOSM> createState() => _MapScreenOSMState();
}

class _MapScreenOSMState extends State<MapScreenOSM> {
  LatLng? _pontoClicado;

  void _selecionarPonto(TapPosition tapPosition, LatLng latLng) {
    setState(() {
      _pontoClicado = latLng;
    });

    final mensagem =
        'Latitude: ${latLng.latitude}, Longitude: ${latLng.longitude}';

    debugPrint(mensagem);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(mensagem),
          duration: const Duration(seconds: 3),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Obter Coordenadas (flutter_map)'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: const LatLng(-22.7130000, -46.8180000),
          initialZoom: 17.0,
          onTap: _selecionarPonto,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.flutter_obter_posicao_map',
          ),
          if (_pontoClicado != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: _pontoClicado!,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(8),
        child: Text(
          _pontoClicado == null
              ? 'Toque em um ponto do mapa para obter as coordenadas.'
              : 'Latitude: ${_pontoClicado!.latitude}\nLongitude: ${_pontoClicado!.longitude}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
