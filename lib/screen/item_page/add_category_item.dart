import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spend_note/util/button.dart';

class AddCategoryItem extends StatefulWidget {
  final String titleHeader;

  const AddCategoryItem({required this.titleHeader, super.key});

  @override
  State<AddCategoryItem> createState() => _AddCategoryItemState();
}

class _AddCategoryItemState extends State<AddCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          widget.titleHeader,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.plus,
                          size: 16.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Chọn icon",
                      style: TextStyle(fontSize: 10.sp, color: Colors.blueAccent),
                    ),
                  ],
                ),
                SizedBox(width: 15.w,),
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 16.sp),
                    decoration: InputDecoration(
                      hintText: "Tên hạng mục",
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[400],
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.box,
                          size: 16.sp,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                  ],
                ),
                SizedBox(width: 15.w,),
                Expanded(
                  child: TextButton(
                      onPressed: (){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Chọn hạng mục cha", style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),),
                          FaIcon(FontAwesomeIcons.chevronRight, size: 16.sp, color: Colors.grey[700],)
                        ],
                      )
                  )
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
            width: double.infinity,
            child: MainButton(text: "Lưu lại", onTap: (){}),
          )
        ],
      ),
    );
  }
}
