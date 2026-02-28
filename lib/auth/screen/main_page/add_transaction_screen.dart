import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:spend_note/util/button.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  //  Hàm chọn ngày
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Hàm chọn giờ
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  // Hàm format chuỗi ngày "Hôm nay - dd/MM/yyyy"
  String _formatDate(DateTime date) {
    String formatted = DateFormat('dd/MM/yyyy').format(date);
    DateTime now = DateTime.now();
    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return "Hôm nay - $formatted";
    }
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlueAccent.withOpacity(0.2), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                header(),
                SizedBox(height: 10.h),
                typeAmount(),
                SizedBox(height: 10.h),
                selectCategory(),
                SizedBox(height: 10.h),
                information(),
                SizedBox(height: 16.sp),
                MainButton(text: "Lưu lại", onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget information() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 12.w),
                  FaIcon(
                    FontAwesomeIcons.moneyCheckDollar,
                    size: 24.sp,
                    color: Colors.lightBlueAccent[400],
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    "Ví",
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey[800]),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          Divider(thickness: 2, color: Colors.grey[200]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => _selectDate(context),
                    icon: FaIcon(
                      FontAwesomeIcons.calendar,
                      size: 20.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    _formatDate(selectedDate),
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey[800]),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => _selectTime(context),
                child: Text(
                  "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}",
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          Divider(thickness: 2, color: Colors.grey[200]),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 12.sp),
              FaIcon(
                FontAwesomeIcons.alignLeft,
                color: Colors.grey[700],
                size: 18.sp,
              ),
              SizedBox(width: 12.sp),
              Expanded(
                child: TextField(
                  controller: _noteController,
                  style: TextStyle(fontSize: 16.sp),
                  decoration: InputDecoration(
                    hintText: "Diễn giải",
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[700],
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget selectCategory() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 12.w),
              FaIcon(
                FontAwesomeIcons.plusSquare,
                size: 18.sp,
                color: Colors.grey[700],
              ),
              SizedBox(width: 12.w),
              Text(
                "Chọn hạng mục",
                style: TextStyle(fontSize: 16.sp, color: Colors.red),
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Tất cả",
              style: TextStyle(fontSize: 16.sp, color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }

  Widget typeAmount() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              "Số tiền",
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: _amountController,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              decoration: InputDecoration(
                counterStyle: TextStyle(color: Colors.red),
                hintText: "0 đ",
                hintStyle: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FaIcon(
          FontAwesomeIcons.clockRotateLeft,
          size: 14.sp,
          color: Colors.grey[700],
        ),
        DropdownMenu(
          width: 150.w,
          label: Text("Chọn loại giao dịch"),
          dropdownMenuEntries: [
            DropdownMenuEntry(
              value: 1,
              label: "Chi tiền",
              leadingIcon: Icon(
                FontAwesomeIcons.minusCircle,
                color: Colors.red,
              ),
            ),
            DropdownMenuEntry(
              value: 2,
              label: "Thu Tiền",
              leadingIcon: Icon(
                FontAwesomeIcons.plusCircle,
                color: Colors.green,
              ),
            ),
          ],
        ),
        FaIcon(FontAwesomeIcons.ticket, size: 14.sp, color: Colors.grey[700]),
      ],
    );
  }
}
