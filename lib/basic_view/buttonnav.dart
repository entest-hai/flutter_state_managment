import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';
import 'package:flutter_provider/basic_view/material_demo_types.dart';
import 'package:flutter_provider/gen/assets.gen.dart';

class BottomNavigationDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GalleryLocalizations.delegate, // Add this line
      ],
      home: BottomNavigationDemo(
          restorationId: '', type: BottomNavigationDemoType.withLabels),
    );
  }
}

class BottomNavigationDemo extends StatefulWidget {
  const BottomNavigationDemo({
    Key key,
    @required this.restorationId,
    @required this.type,
  }) : super(key: key);

  final String restorationId;
  final BottomNavigationDemoType type;

  @override
  State<StatefulWidget> createState() {
    return _BottomNavigationDemoState();
  }
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo>
    with RestorationMixin {
  final RestorableInt _currentindex = RestorableInt(0);

  @override
  String get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(_currentindex, 'bottom_navigation_tab_index');
  }

  @override
  void dispose() {
    _currentindex.dispose();
    super.dispose();
  }

  String _title(BuildContext context) {
    return GalleryLocalizations.of(context)
        .demoBottomNavigationPersistentLabels;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textScheme = Theme.of(context).textTheme;

    var bottomNavigationBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const Icon(Icons.add_comment),
        label: GalleryLocalizations.of(context).bottomNavigationCommentsTab,
      ),
      BottomNavigationBarItem(
          icon: const Icon(Icons.calendar_today),
          label: GalleryLocalizations.of(context).bottomNavigationCalendarTab),
      BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle),
          label: GalleryLocalizations.of(context).bottomNavigationAccountTab),
      BottomNavigationBarItem(
          icon: const Icon(Icons.alarm_on),
          label: GalleryLocalizations.of(context).bottomNavigationAlarmTab),
      BottomNavigationBarItem(
          icon: const Icon(Icons.camera_enhance),
          label: GalleryLocalizations.of(context).bottomNavigationCameraTab)
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_title(context)),
      ),
      body: Center(
        child: _NavigationDestinationView(
          key: UniqueKey(),
          item: bottomNavigationBarItems[_currentindex.value],
          index: _currentindex.value,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex.value,
        showSelectedLabels: widget.type == BottomNavigationDemoType.withLabels,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.onPrimary,
        unselectedItemColor: colorScheme.onPrimary.withOpacity(0.38),
        backgroundColor: colorScheme.primary,
        items: bottomNavigationBarItems,
        onTap: (index) {
          setState(() {
            _currentindex.value = index;
          });
          ;
        },
      ),
    );
  }
}

class _NavigationDestinationView extends StatelessWidget {
  _NavigationDestinationView({Key key, this.item, this.index})
      : super(key: key);
  final BottomNavigationBarItem item;
  final int index;
  final images = [
    Assets.images.tokyo1.path,
    Assets.images.tokyo2.path,
    Assets.images.tokyo3.path,
    Assets.images.tokyo4.path,
    Assets.images.tokyo1.path
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ExcludeSemantics(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(images[this.index]),
              ),
            ),
          ),
        )
      ],
    );
  }
}
