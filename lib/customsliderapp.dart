import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'testcustompainter.dart';

class CustomSliderApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (context) => HeartRateCubit()..loadHeartRateFromFile())
      ],
      child: Scaffold(
        appBar: AppBar(title: Text("CTG View Slider"),
        ),
        body: CustomSliderView(
          onChanged: (value){ print("on change $value");},
          acels:  [Acceleration(start: 0, duration: 2.0),
                                    Acceleration(start: 5, duration: 2.0),
                                    Acceleration(start: 15, duration: 4.0),],
          decels: [Deceleration(start: 20, duration: 1.0),
                                     Deceleration(start: 35, duration: 2.0),
                                     Deceleration(start: 45, duration: 3.0),
                                     Deceleration(start: 55, duration: 2.0),
                                     ],
          ),
        ),
        )
    );
  }
}

// Slidding Window and ACC Mark Painter 
class CustomSliderView extends StatefulWidget {
  final List<Acceleration> acels;
  final List<Deceleration> decels; 
  final int numMinute;
  final double sliderWidth; 
  final double sliderHeight; 
  final Color color; 
  final ValueChanged<double> onChanged; 
  final ValueChanged<double> onChangeStart;
  final ValueChanged<double> onChangeEnd;

  CustomSliderView({
    this.acels,
    this.decels,
    this.numMinute = 60,
    this.sliderWidth = 380.0,
    this.sliderHeight = 45.0,
    this.color = Colors.black,
    this.onChanged,
    this.onChangeEnd,
    this.onChangeStart,
  });

  @override 
  State<StatefulWidget> createState() {
    return _CustomSliderState();
  }
}

// Slidding Window and ACC Mark Painter 
class _CustomSliderState extends State<CustomSliderView> {
  double _dragPosition = 0.0; 
  double _dragPercentage = 0.0;

   ScrollController _scrollController = new ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );
 
  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
      BlocBuilder<HeartRateCubit, HeartRateState>(builder: (context, state){
        if (state is LoadingHeartRate) {
          return Container(
            child: Center(child: CircularProgressIndicator(),),
          );
        } else if (state is LoadedHeartRateScucess) {
          return SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: CustomPaint(
          // painter: CTGGridPainterTest(),
          painter: CTGGridPainter(mHR: state.mHR, fHR: state.fHR),
          size: Size(MediaQuery.of(context).size.width*6, 300),
          ),
      );
        }
      }),

      GestureDetector(
        child: Stack(children: [
          CustomPaint(
            painter: SliderPainter(
              width: widget.sliderWidth/widget.numMinute*10,
              height: widget.sliderHeight + 6,
              margin: 3,
              maxWidth: widget.sliderWidth,
              color: Colors.blue,
              dragPercentage: _dragPercentage,
              sliderPosition: _dragPosition
            ),
          ),
          CustomPaint(
            painter: 
            CTGPainter(
              acels: widget.acels,
              decels: widget.decels,
              numMinute: widget.numMinute,
              width: widget.sliderWidth,
              height: widget.sliderHeight),
              ),
          Container(
            color: Colors.grey.withOpacity(0.1),
            height: widget.sliderHeight,
            width: widget.sliderWidth,
          ),
        ],
        ),
      onHorizontalDragUpdate: (DragUpdateDetails update) => _onDragUpdate(context, update),
      onHorizontalDragStart: (DragStartDetails start) => _onDragStart(context, start),
      onHorizontalDragEnd: (DragEndDetails end) => _onDragEnd(context, end),
      ),

      ],
    );
  }

  _handleChanged(double val, double ctgPaperWidth){
    assert(widget.onChanged != null);
    widget.onChanged(val);

    //
    _scrollController.animateTo(_dragPercentage * ctgPaperWidth,
     duration: Duration(microseconds: 10),
      curve: Curves.ease);
  }

   _handleChangeStart(double val) {
    // assert(widget.onChangeStart != null);
    // widget.onChangeStart(val);
  }

  _handleChangeEnd(double val) {
    // assert(widget.onChangeEnd != null);
    // widget.onChangeEnd(val);
  }

   void _onDragStart(BuildContext context, DragStartDetails start) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(start.globalPosition);
    _updateDragPosition(offset);
    _handleChangeStart(_dragPercentage);
  }

  void _onDragUpdate(BuildContext context,  DragUpdateDetails update) {
    RenderBox box =  context.findRenderObject();
    Offset offset = box.globalToLocal(update.globalPosition);
    _updateDragPosition(offset);
    _handleChanged(_dragPercentage, MediaQuery.of(context).size.width*6.0);

  }

  void _onDragEnd(BuildContext context, DragEndDetails end) {
    setState(() {});
    _handleChangeEnd(_dragPercentage);
  }

  void _updateDragPosition(Offset val) {
    double newDragPosition = 0; 
    if (val.dx <= 0) {
      newDragPosition = 0; 
    } else if (val.dx >= widget.sliderWidth) {
      newDragPosition = widget.sliderWidth; 
    } else {
      newDragPosition = val.dx; 
    }

    setState(() { 
      _dragPosition = newDragPosition;
      _dragPercentage = _dragPosition / widget.sliderWidth;
      });
  }

}


// Slidding Window Painter 
class SliderPainter extends CustomPainter {
  final double margin; 
  final double width;
  final double height; 
  final double maxWidth;
  final double sliderPosition; 
  final double dragPercentage; 
  final Color color; 
  final Paint wavePainter; 

  SliderPainter({
    this.margin,
    this.width, 
    this.height,
    this.maxWidth,
    this.sliderPosition,
    this.dragPercentage,
    this.color,
    }): wavePainter = Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  @override 
  void paint(Canvas canvas, Size size) {
    _paintBlock(canvas, size);
  }

  @override 
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; 
  }
  _paintBlock(Canvas canvas, Size size){
    
    Rect sliderRect = Offset(sliderPosition, size.height - margin) & Size(width, height);
    canvas.drawRect(sliderRect, wavePainter);
  }
}


// ACC Mark Mark Painter 
class CTGPainter extends CustomPainter {
  final List<Acceleration> acels; 
  final List<Deceleration> decels;
  final int numMinute; 
  final double width; 
  final double height; 
  CTGPainter({
    this.acels, 
    this.decels,
    this.numMinute,
    this.width,
    this.height}); 
  @override 
  void paint(Canvas canvas, Size size) {
    //
    final minuteWidth = width/numMinute;

    final rectPainter = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2; 
    // Draw rect 
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), rectPainter);

    // Draw accelerations
    final acelPainter = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill;
    for (var acel in acels) {
      canvas.drawRect(Rect.fromLTWH(acel.start*minuteWidth, 0, acel.duration*minuteWidth, height), acelPainter); 
    }
    

    // Draw deceleration 
    final decelPainter = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;
    for (var decel in decels){
       canvas.drawRect(Rect.fromLTWH(decel.start*minuteWidth, 0, decel.duration*minuteWidth, height), decelPainter);
    }
    
  }

  @override 
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; 
  }
}

// CTG Painter 
class CTGGridPainterTest extends CustomPainter {
  final int numMinute; 
  CTGGridPainterTest({this.numMinute = 60});
  @override 
  void paint(Canvas canvas, Size size) {
    // Minute To Width 
    final minuteWidth = size.width/numMinute;

    // Draw CTG Paper Border 
    Paint rectPainter = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.5;
    canvas.drawRect(Rect.fromLTWH(10, 10, size.width - 20, size.height - 20), rectPainter);    

    // Draw One Minute Mark
    Paint minutePainter = Paint()
    ..color = Colors.black.withOpacity(0.2)
    ..style = PaintingStyle.fill
    ..strokeWidth = 1.0;
    for(var i = 0; i < numMinute/5; i++){
      canvas.drawRect(Rect.fromLTWH(10 + i*5.0*minuteWidth, 10, size.width/(2*numMinute), size.height - 20), minutePainter);    
    }

  }

  @override 
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; 
  }
}


// Accel and Decel Model 
class Acceleration {
  final double start; 
  final double duration; 
  Acceleration({this.start, this.duration});
}

class Deceleration {
  final double start; 
  final double duration; 
  Deceleration({this.start, this.duration});
}