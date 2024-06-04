import 'dart:developer';

import 'package:fee_verification_teacher/home/bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';

import '../../constance/constents.dart';
import '../../utils/pop-up.dart';


class AllFeeReceipt extends StatefulWidget {

  static final routeName = '/allFeeReceipt';


  AllFeeReceipt({Key? key, required this.feeReceiptIds}) : super(key: key);

  List<String> feeReceiptIds;

  @override
  State<AllFeeReceipt> createState() => _AllFeeReceiptState();
}

class _AllFeeReceiptState extends State<AllFeeReceipt> {

  @override
  void initState() {

    context.read<HomeBloc>().add(GetFeeReceiptByIds(  receiptId: widget.feeReceiptIds,));
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
          if(state.status == HomeStateStatus.loaded){
            return Center(
              child: state.feeReceiptList != null
                  ? ListView.builder(
                itemCount: state.feeReceiptList!.length,
                itemBuilder: (context, index) {



                  return ListTile(
                    leading: PopupMenuButton<String>(
                        onSelected: (value) {
                      // Handle the selected menu item
                      print('Selected: $value');

                      if(value == ListConstent.feeReceiptStatus[0]) {
                        context.read<HomeBloc>().add(UpdateFeeReceipt(receiptId: widget.feeReceiptIds,feeReceiptModel: state.feeReceiptList![index].copyWith(receiptStatus: ListConstent.feeReceiptStatus[0], receiptVerifiedBy: "Receipt verified by ${state.facultyModel!.facultyName} (${state.facultyModel!.facultyAssociateWith})")));
                      }if(value == ListConstent.feeReceiptStatus[1]) {
                        context.read<HomeBloc>().add(UpdateFeeReceipt(receiptId: widget.feeReceiptIds,feeReceiptModel: state.feeReceiptList![index].copyWith(receiptStatus: ListConstent.feeReceiptStatus[1],receiptVerifiedBy: "Receipt verified by ${state.facultyModel!.facultyName} (${state.facultyModel!.facultyAssociateWith})" )));
                      }if(value == ListConstent.feeReceiptStatus[2]) {
                        context.read<HomeBloc>().add(UpdateFeeReceipt(receiptId: widget.feeReceiptIds,feeReceiptModel: state.feeReceiptList![index].copyWith(receiptStatus: ListConstent.feeReceiptStatus[2],receiptVerifiedBy: "Receipt verified by ${state.facultyModel!.facultyName} (${state.facultyModel!.facultyAssociateWith})" )));
                      }
                    },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                              value: ListConstent.feeReceiptStatus[0],
                              child: Text('${ListConstent.feeReceiptStatus[0]}',style: TextStyle(color: Colors.black),),
                            ),
                            PopupMenuItem<String>(
                              value: ListConstent.feeReceiptStatus[1],
                              child: Text(ListConstent.feeReceiptStatus[1],style: TextStyle(color: Colors.green),),
                            ),
                            PopupMenuItem<String>(
                              value: ListConstent.feeReceiptStatus[2],
                              child: Text(ListConstent.feeReceiptStatus[2],style: TextStyle(color: Colors.red),),
                            ),
                          ];
                        },
                        child: leadingIcon(state.feeReceiptList![index].receiptStatus!)),
                    title: Text(state.feeReceiptList![index].receiptType!),
                    subtitle: Text("${state.feeReceiptList![index].receiptYear!} ${state.feeReceiptList![index].receiptStatus!}"),
                    onTap: (){

                      showPopUp(context: context,children: [

                        Container(
                          height: 400,
                          width: 400,
                          child: PhotoView(
                            imageProvider: NetworkImage(state.feeReceiptList![index].receiptUrl!),
                          ),
                        ),
                      Text('Receipt Type: ${state.feeReceiptList![index].receiptType!}'),
                      Text('Receipt Year: ${state.feeReceiptList![index].receiptYear!}'),
                      Text('Receipt Status: ${state.feeReceiptList![index].receiptStatus!}'),
                      Text('Receipt Amount: ${state.feeReceiptList![index].receiptAmount!}')
                      ]);

                    },
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

  Widget leadingIcon(String? receiptStatus) {

    if(receiptStatus == ListConstent.feeReceiptStatus[0]){
      return Container(decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.yellow),child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: const Icon(Icons.padding_outlined,color: Colors.black,),
      ));
    }
    if(receiptStatus == ListConstent.feeReceiptStatus[1]){
      return Container(
        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.approval_rounded,color: Colors.white,),
        ),
      );
    }
    if(receiptStatus == ListConstent.feeReceiptStatus[2]){
      return Container(
        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.close,color: Colors.white,),
        ),
      );
    }

    return SizedBox();

  }


}
