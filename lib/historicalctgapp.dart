import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoricalCTGApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => RecordCubit()..fetchRecord("123")),
          BlocProvider(create: (context) => PatientCTGCubit())
        ],
        child: HistoricalCTGView(),
      ),
    );
  }
}

class HistoricalCTGView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoricalCTGState();
  }
}

class _HistoricalCTGState extends State<HistoricalCTGView> {
  var _selectedCard;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Historical CTG"),
        ),
        body: BlocBuilder<RecordCubit, RecordState>(
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  height: 50,
                  color: Colors.grey.withOpacity(0.2),
                  child: BlocBuilder<RecordCubit, RecordState>(
                    builder: (context, state) {
                      if (state is LoadingRecord) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is LoadedRecordSuccess) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.records.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print("tap card $index");
                                BlocProvider.of<PatientCTGCubit>(context)
                                    .fetchCTG("$index");
                                setState(() {
                                  _selectedCard = index;
                                });
                              },
                              child: Card(
                                child: SizedBox(
                                  width: 100,
                                  child: Center(
                                    child: Text(
                                        "Record ${state.records[index].createdTime}"),
                                  ),
                                ),
                                color: index == _selectedCard
                                    ? Colors.grey
                                    : Colors.white,
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text("Exception"),
                        );
                      }
                    },
                  ),
                ),
                Container(
                    height: 400,
                    color: Colors.green.withOpacity(0.5),
                    child: BlocBuilder<PatientCTGCubit, PatientCTGState>(
                      builder: (context, state) {
                        if (state is LoadingPatientCTG) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is LoadedPatientCTGSuccess) {
                          return Image(
                              image: AssetImage(
                                  "assets/whale_" + state.ctg.id + ".jpg"));
                        }
                        return Center(
                          child: Text("Exception"),
                        );
                      },
                    )),
                Expanded(
                    child: Container(
                  color: Colors.grey.withOpacity(0.0),
                  child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) => SizedBox(height: 0),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            child: index == 0
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Time",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Duration",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Time",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("    ")
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                        Text("2:00PM"),
                                        Text("1.30 minute"),
                                        Text("6:00 minute"),
                                        Icon(
                                          Icons.circle,
                                          color: Colors.blue,
                                        ),
                                      ])),
                      );
                    },
                  ),
                )),
              ],
            );
          },
        ));
  }
}

// Record Model Per Patient
class Record {
  final String patientId;
  final String createdTime;
  Record({this.patientId, this.createdTime});
}

// Record Repository
class RecordRepository {
  Future<List<Record>> fetchRecord(String patientId) async {
    final List<Record> records = [
      Record(patientId: "123", createdTime: "01"),
      Record(patientId: "124", createdTime: "02"),
      Record(patientId: "125", createdTime: "03"),
      Record(patientId: "126", createdTime: "04"),
      Record(patientId: "127", createdTime: "05"),
      Record(patientId: "128", createdTime: "06"),
      Record(patientId: "129", createdTime: "07")
    ];
    print("fetch record of a patient from db");
    Future.delayed(Duration(seconds: 3), () {
      print("records responsed from db");
    });
    return records;
  }
}

// Record Cubit
abstract class RecordState {}

class LoadingRecord extends RecordState {}

class LoadedRecordSuccess extends RecordState {
  final List<Record> records;
  LoadedRecordSuccess({this.records});
}

class RecordCubit extends Cubit<RecordState> {
  final _recordRepository = RecordRepository();
  RecordCubit() : super(LoadingRecord());

  Future<void> fetchRecord(String patientId) async {
    final records = await _recordRepository.fetchRecord(patientId);

    Future.delayed(Duration(seconds: 2), () {
      emit(LoadedRecordSuccess(records: records));
    });
  }
}

// CTG Model Per Patient
class PatientCTG {
  final List<double> mHR;
  final List<double> fHR;
  final String id;
  PatientCTG({this.mHR, this.fHR, this.id});
}

// CTG Patient Repostiory
class PatientCTGRepository {
  Future<PatientCTG> fetchCTG(String patientId) async {
    print("fetch patient CTG from db");
    Future.delayed(Duration(seconds: 2), () {});
    final ctg = PatientCTG(mHR: [60.0], fHR: [150.0], id: patientId);
    return ctg;
  }
}

// Patient CTG Cubit
abstract class PatientCTGState {}

class LoadingPatientCTG extends PatientCTGState {}

class LoadedPatientCTGSuccess extends PatientCTGState {
  final PatientCTG ctg;
  LoadedPatientCTGSuccess({this.ctg});
}

class PatientCTGCubit extends Cubit<PatientCTGState> {
  final _patientCTGRepository = PatientCTGRepository();
  PatientCTGCubit() : super(LoadingPatientCTG());

  Future<void> fetchCTG(String patientId) async {
    emit(LoadingPatientCTG());
    final ctg = await _patientCTGRepository.fetchCTG(patientId);
    Future.delayed(Duration(seconds: 3), () {
      emit(LoadedPatientCTGSuccess(ctg: ctg));
      print("responsed ctg from db");
    });
  }
}


// _selectedCard == null
//                       ? Center(
//                           child: Text("null"),
//                         )
//                       : Image(
//                           fit: BoxFit.cover,
//                           image: AssetImage(
//                               "assets/whale_" + "$_selectedCard" + ".jpg"),
//                         ),