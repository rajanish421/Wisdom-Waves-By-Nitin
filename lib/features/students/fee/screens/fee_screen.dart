import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wisdom_waves_by_nitin/Model/fee_model.dart';
import 'package:wisdom_waves_by_nitin/Model/students_model.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';
import 'package:wisdom_waves_by_nitin/features/students/fee/services/fee_services.dart';

class FeeScreen extends StatefulWidget {
  final Students student;
  const FeeScreen({super.key,required this.student});
  @override
  State<FeeScreen> createState() => _FeeScreenState();
}

class _FeeScreenState extends State<FeeScreen> {
  FeeServices feeServices = FeeServices();
  Fee? fee;
   int paidAmount = 0;
   String paidAt = "";

  double progress = 0;

 // 100% paid

  List<Map<String, dynamic>> payments = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFeeData();
  }

  void getFeeData()async{
    final res = await feeServices.getFee(widget.student.userId);
    setState(() {
      fee = res;
      payments.clear();
      payments.addAll(fee!.payments);
      paidAmount = 0;
      calculatePaidAmount();
    });
  }

  void calculatePaidAmount(){
    for(var i in payments){
      int amount = int.parse(i["amount"]);
      print(amount);
          paidAmount += amount;
    }
  }


  @override
  Widget build(BuildContext context) {

    if(fee !=null){
      Timestamp timestamp = fee!.lastPayment['paidAt'];
      DateTime date = timestamp.toDate();
      paidAt  = DateFormat('dd MMM yyyy, hh:mm a').format(date).toString();
      progress = paidAmount/fee!.totalFee;
      print(progress);
      print(paidAmount);
      print(fee!.totalFee);

    }
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("My Fees", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
        // foregroundColor: Colors.red,
        elevation: 0,
      ),
      body:fee == null ? Center(child: Text("No data"),): Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fee Summary Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Fee Summary",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold,)),
                        Text("Due: ₹${fee!.dueFee}",
                            style: TextStyle(
                                fontSize: 16, color: Colors.red[700],fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Paid: ₹$paidAmount",
                            style: TextStyle(
                                fontSize: 16, color: Colors.green[700],fontWeight: FontWeight.bold)),
                        Text("Total Amount: ₹${fee!.totalFee}",
                            style: TextStyle(
                                fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 20,
                        backgroundColor: Colors.grey[300],
                        color: AppColors.appBarColor,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Last Payment: ${fee!.lastPayment['amount']} on ${paidAt}",
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Monthly Fee Details
            Text("Payments History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  if(payments.length<=0){
                    return null;
                  }
                  final payment = payments[index];
                  Timestamp timestamp = payment['paidAt'];
                  DateTime date = timestamp.toDate();
                  String payDate  = DateFormat('dd MMM yyyy, hh:mm a').format(date).toString();
                  return Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(Icons.check_circle,
                          color: Colors.green, size: 28),
                      title: Text(
                        "${payDate}",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        "₹${payment['amount']}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
