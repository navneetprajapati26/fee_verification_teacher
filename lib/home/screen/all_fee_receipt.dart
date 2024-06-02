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
                    leading: leadingIcon(state.feeReceiptList![index].receiptStatus!),
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

    if(receiptStatus == ListConstent.FeeReceiptStatus[0]){
      return Container(decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.yellow),child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: const Icon(Icons.padding_outlined,color: Colors.black,),
      ));
    }
    if(receiptStatus == ListConstent.FeeReceiptStatus[1]){
      return Container(
        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.approval_rounded,color: Colors.white,),
        ),
      );
    }
    if(receiptStatus == ListConstent.FeeReceiptStatus[2]){
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
