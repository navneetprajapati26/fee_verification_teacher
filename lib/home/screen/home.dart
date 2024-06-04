import 'dart:developer';

import 'package:fee_verification_teacher/home/bloc/home_bloc.dart';
import 'package:fee_verification_teacher/home/screen/all_fee_receipt.dart';
import 'package:fee_verification_teacher/utils/year_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constance/constents.dart';
import '../../main.dart';
import '../../utils/dropdown_button.dart';
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

  String? branchFilter = "Branch";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          // controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black54),
          ),
          style: TextStyle(color: Colors.black54, fontSize: 16.0),
          onChanged: (value) {
            log(value);
            context.read<HomeBloc>().add(DoFilterByQuery(query: value));

          },
        ),
        actions: [
          PopupMenuButton<String>(
              onSelected: (value) {
                // Handle the selected menu item
                print('Selected: $value');

                if(value == "All Student") {
                  context.read<HomeBloc>().add(GetAllStudent());
                }if(value == ListConstent.branches[0]) {
                  context.read<HomeBloc>().add(DoFilterByBranch(branch: ListConstent.branches[0]));
                }if(value == ListConstent.branches[1]) {
                  context.read<HomeBloc>().add(DoFilterByBranch(branch: ListConstent.branches[1]));
                }if(value == ListConstent.branches[2]) {
                  context.read<HomeBloc>().add(DoFilterByBranch(branch: ListConstent.branches[2]));
                }
                setState(() {
                  branchFilter = value;
                });

              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: "All Student",
                    child: Text('All Student',style: TextStyle(color: Colors.black),),
                  ),
                  PopupMenuItem<String>(
                    value: ListConstent.branches[0],
                    child: Text('${ListConstent.branches[0]}',style: TextStyle(color: Colors.black),),
                  ),
                  PopupMenuItem<String>(
                    value: ListConstent.branches[1],
                    child: Text(ListConstent.branches[1],style: TextStyle(color: Colors.black),),
                  ),
                  PopupMenuItem<String>(
                    value: ListConstent.branches[2],
                    child: Text(ListConstent.branches[2],style: TextStyle(color: Colors.black),),
                  ),
                ];
              },
              child: Text(branchFilter!,style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),),),
          // CustomDropdownButton(
          //   items:ListConstent.years,
          //   hint: 'Select faculty Associate With',
          //   onChanged: (value) {
          //
          //     setState(() {
          //       _facultyAssociateWith = value!;
          //     });
          //
          //     print('Selected: $_facultyType');
          //
          //
          //   },
          // ),
          SizedBox(width: 8,),
          YearPickerWidget(
            width: 130,
            border: Border.all(width: 0, color: Colors.transparent),
            padding: EdgeInsets.zero,
            startYear: 2014,
            endYear: 2050,
            onYearChanged: (v){
            context.read<HomeBloc>().add(DoFilterByYear(year: v.toString()));

          },),

          SizedBox(width: 8,)
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {


          if (state.status == HomeStateStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == HomeStateStatus.loaded || state.status == HomeStateStatus.filter) {
            return Center(
              child: state.studentList != null
                  ? ListView.builder(
                      itemCount: state.status == HomeStateStatus.filter ? state.filteredStudentList!.length :state.studentList!.length,
                      itemBuilder: (context, index) {

                        var student =  state.status == HomeStateStatus.filter ? state.filteredStudentList![index] : state.studentList![index];

                        return ListTile(
                          onTap: () {
                            // showPopUp(context: context, children: [
                            //   Text(state.studentList![index].yearOfAdmission),
                            //   Text(state.studentList![index].studentRollNo),
                            //   Text(state.studentList![index].studentYear),
                            //   SizedBox(
                            //     height: 30,
                            //   ),
                            //   TextButton(
                            //     child: Text("Verify this student"),
                            //     onPressed: () {
                            //       context.read<HomeBloc>().add(UpdateStudent(
                            //           studentModel: state.studentList![index]
                            //               .copyWith(isStudentVerified: true)));
                            //       Navigator.of(context).pop();
                            //     },
                            //   )
                            //
                            //   // for (int i = 0; i < state.studentList![index].studentFeeReceiptsIdList!.length; i++)
                            //   //   Text(state.studentList![index].studentFeeReceiptsIdList![i])
                            // ]);
                            Navigator.pushNamed(
                              context,
                              AllFeeReceipt.routeName,
                              arguments: AllFeeReceiptArguments(student.studentFeeReceiptsIdList!),
                            );
                          },
                          title: Text(student.yearOfAdmission),
                          subtitle: Text("Roll No ${student.studentRollNo} Branch :-  ${student.studentBranch}"),
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
                                                  studentModel: student
                                                      .copyWith(isStudentVerified: true)));
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    : TextButton(
                                        child: Text("block ${student.studentName}"),
                                        onPressed: () {
                                          context.read<HomeBloc>().add(
                                              UpdateStudent(
                                                  studentModel: student
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
