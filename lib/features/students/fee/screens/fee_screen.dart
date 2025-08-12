import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';

class FeeScreen extends StatefulWidget {
  @override
  State<FeeScreen> createState() => _FeeScreenState();
}

class _FeeScreenState extends State<FeeScreen> {
   int paidAmount = 0;

  final int dueAmount = 0;

  final double progress = 0.5;
 // 100% paid
  final String lastPaymentAmount = "₹343";

  final String lastPaymentDate = "12 Aug 2025";

  final List<Map<String, dynamic>> payments = [
    {"amount": 6, "date": "12 Aug 2025"},
    {"amount": 4, "date": "12 Aug 2025"},
    {"amount": 3, "date": "12 Aug 2025"},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculatePaidAmount();
  }

  void calculatePaidAmount(){
    for(var i in payments){
          paidAmount += i["amount"] as int;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("My Fees", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
        // foregroundColor: Colors.red,
        elevation: 0,
      ),
      body: Padding(
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
                        Text("Due: ₹$dueAmount",
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
                        Text("Total Amount: ₹5000",
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
                      "Last Payment: $lastPaymentAmount on $lastPaymentDate",
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
                  final payment = payments[index];
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
                        "${payment['date']}",
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
