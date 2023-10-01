import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AppLocalizations _localization = AppLocalizationsEn();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    _localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: _buildBody(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
            //activeIcon: Icon(Icons.home, color: Colors.blue)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
            //activeIcon: Icon(Icons.favorite, color: Colors.blue)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Búsqueda',
            //activeIcon: Icon(Icons.search)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Salir',
            //activeIcon: Icon(Icons.exit_to_app, color: Colors.blue)
          )
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return Text('Esta es la pantalla de inicio');
      case 1:
        return Text('Esta es la pantalla de favoritos');
      case 2:
        return Text('Esta es la pantalla de búsqueda');
      default:
        return Text('Esta es la pantalla de salida');
    }
  }
}

class BusquedaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Búsqueda'),
      ),
      body: Center(
        child: Text('Esta es la pantalla de búsqueda'),
      ),
    );
  }
}
