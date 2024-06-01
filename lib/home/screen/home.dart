import 'package:fee_verification_teacher/home/bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/pop-up.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    context.read<HomeBloc>().add(GetAllStudent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Fee receipts'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStateStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == HomeStateStatus.loaded) {
            return Center(
              child: state.studentList != null
                  ? ListView.builder(
                      itemCount: state.studentList!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            showPopUp(context: context, children: [
                              Text(state.studentList![index].username),
                              Text(state.studentList![index].studentRollNo),
                              Text(state.studentList![index].studentYear),
                              SizedBox(
                                height: 30,
                              ),
                              TextButton(
                                child: Text("Verify this student"),
                                onPressed: () {
                                  context.read<HomeBloc>().add(UpdateStudent(
                                      studentModel: state.studentList![index]
                                          .copyWith(isStudentVerified: true)));
                                  Navigator.of(context).pop();
                                },
                              )

                              // for (int i = 0; i < state.studentList![index].studentFeeReceiptsIdList!.length; i++)
                              //   Text(state.studentList![index].studentFeeReceiptsIdList![i])
                            ]);
                          },
                          title: Text(state.studentList![index].username),
                          subtitle: Text(
                              "Roll No ${state.studentList![index].studentRollNo} Branch :-  ${state.studentList![index].studentBranch}"),
                          leading: InkWell(
                            onTap: () {
                              showPopUp(context: context, children: [
                                SizedBox(
                                  height: 30,
                                ),
                                !state.studentList![index].isStudentVerified!
                                    ? TextButton(
                                        child: Text("Verify this student"),
                                        onPressed: () {
                                          context.read<HomeBloc>().add(
                                              UpdateStudent(
                                                  studentModel: state
                                                      .studentList![index]
                                                      .copyWith(
                                                          isStudentVerified:
                                                              true)));
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    : TextButton(
                                        child: Text("block ${state.studentList![index].studentName}"),
                                        onPressed: () {
                                          context.read<HomeBloc>().add(
                                              UpdateStudent(
                                                  studentModel: state
                                                      .studentList![index]
                                                      .copyWith(
                                                          isStudentVerified:
                                                              false)));
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                SizedBox(
                                  height: 30,
                                ),
                              ]);
                            },
                            child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: state.studentList![index]
                                            .isStudentVerified!
                                        ? Colors.green
                                        : Colors.red),
                                child: Icon(
                                  state.studentList![index].isStudentVerified!
                                      ? Icons.gpp_good_rounded
                                      : Icons.power_off_sharp,
                                  color: Colors.white,
                                )),
                          ),
                        );
                      },
                    )
                  : Text('No image uploaded'),
            );
          }
          return const Center(
            child: Text('All Fee receipts'),
          );
        },
      ),
    );
  }
}
