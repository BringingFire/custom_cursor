import 'package:custom_cursor/custom_cursor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';

const kCrosshair = 'crosshair';
const kGridPadding = 16.0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final crosshairImgData = await rootBundle.load('assets/crosshair.png');
  CustomCursorPlatform.instance.register(
    kCrosshair,
    image: crosshairImgData.buffer.asUint8List(),
    hotSpot: const Offset(12, 23),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(kGridPadding),
          child: Row(
            children: [
              const Expanded(
                child: MouseRegion(
                  cursor: SystemMouseCursors.precise,
                  child: RegionLabel(label: 'System Cursor'),
                ),
              ),
              const SizedBox(width: kGridPadding),
              Expanded(
                child: Column(
                  children: const [
                    Expanded(
                      child: MouseRegion(
                        cursor: CustomCursor(kCrosshair),
                        child: RegionLabel(label: 'Custom cursor'),
                      ),
                    ),
                    SizedBox(height: kGridPadding),
                    Expanded(
                      child: IconMouseRegion(
                        icon: FractionalTranslation(
                          translation: Offset(-0.5, -1),
                          child: Icon(LucideIcons.crosshair),
                        ),
                        child: RegionLabel(
                          label: 'Hidden cursor, positioned widget',
                        ),
                      ),
                    ),
                    SizedBox(height: kGridPadding),
                    Expanded(
                      child: RegionLabel(
                        label: 'No mouse region',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegionLabel extends StatelessWidget {
  const RegionLabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(label),
    );
  }
}

class IconMouseRegion extends StatefulWidget {
  const IconMouseRegion({
    super.key,
    required this.icon,
    required this.child,
  });

  final Widget icon;
  final Widget child;

  @override
  State<IconMouseRegion> createState() => _IconMouseRegionState();
}

class _IconMouseRegionState extends State<IconMouseRegion> {
  Offset? mouseOffset;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onHover: (event) {
        setState(() {
          mouseOffset = event.localPosition;
        });
      },
      onExit: (_) {
        setState(() {
          mouseOffset = null;
        });
      },
      child: Stack(
        children: [
          Positioned.fill(child: widget.child),
          if (mouseOffset != null)
            Positioned(
              left: mouseOffset!.dx,
              top: mouseOffset!.dy,
              child: widget.icon,
            ),
        ],
      ),
    );
  }
}
