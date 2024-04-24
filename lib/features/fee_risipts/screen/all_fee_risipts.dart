import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widget/viwe_pdf.dart';
import '../bloc/fee_receipt_bloc.dart';

class AllFeeReceipt extends StatefulWidget {
  const AllFeeReceipt({Key? key}) : super(key: key);

  @override
  State<AllFeeReceipt> createState() => _AllFeeReceiptState();
}

class _AllFeeReceiptState extends State<AllFeeReceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Fee receipts'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<FeeReceiptBloc>().add(UploadImageEvent('your_folder_name'));
            },
            child: const Icon(Icons.cloud_upload),
            heroTag: 'imageUpload',
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              context.read<FeeReceiptBloc>().add(UploadPDFEvent('your_folder_name'));
            },
            child: const Icon(Icons.picture_as_pdf),
            heroTag: 'pdfUpload',
          ),
        ],
      ),
      body: BlocBuilder<FeeReceiptBloc, FeeReceiptState>(
        builder: (context, state) {
          if (state is ImageUploadCompletedState) {
            return Center(
              child: state.imageUrl != null
                  ? Image.network(state.imageUrl!)
                  : Text('No image uploaded'),
            );
          } else if (state is PDFUploadCompletedState) {
            return Center(
              child: state.pdfUrl != null
                  ? ViewPDF( url: state.pdfUrl! )
                  : Text('No PDF uploaded'),
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