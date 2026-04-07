import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spend_note/data/firebase/firestore.dart';
import 'package:spend_note/data/model/category_model.dart';
import 'package:spend_note/util/button.dart';

class AddCategoryItem extends StatefulWidget {
  final String titleHeader;

  const AddCategoryItem({required this.titleHeader, super.key});

  @override
  State<AddCategoryItem> createState() => _AddCategoryItemState();
}

class _AddCategoryItemState extends State<AddCategoryItem> {

  CategoryGroup? _selectedParent;
  final FireStore _fireStore = FireStore();

  final TextEditingController _nameController = TextEditingController();
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
                    controller: _nameController,
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
                      onPressed: _showParentCategoryPicker,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedParent?.name ?? "Chọn hạng mục cha",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: _selectedParent == null ? Colors.grey[600] : Colors.black
                            ),
                          ),
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
            child: MainButton(text: "Lưu lại", onTap: _saveCategory),
          )
        ],
      ),
    );
  }

  void _showParentCategoryPicker() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(15.w),
          height: 400.h,
          child: Column(
            children: [
              Text("Chọn hạng mục cha", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.h),
              Expanded(
                child: StreamBuilder<List<CategoryGroup>>(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("Chưa có hạng mục nào"));
                    }

                    final categories = snapshot.data!;

                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final item = categories[index];
                        return ListTile(
                          leading: Icon(item.groupIcon, color: item.color),
                          title: Text(item.name),
                          onTap: () {
                            setState(() {
                              _selectedParent = item; // Cập nhật biến đã chọn
                            });
                            Navigator.pop(context); // Đóng BottomSheet
                          },
                        );
                      },
                    );
                  },
                  stream: _fireStore.getCategories(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveCategory() async {
    String name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập tên hạng mục")),
      );
      return;
    }
    CategoryGroup newCategory = CategoryGroup(
      id: '',
      name: name,
      groupIcon: FontAwesomeIcons.bowlFood,
      color: Colors.blue,
      tags: [],
      type: "expense",
    );

    try {
      await _fireStore.addCategory(newCategory);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Thêm hạng mục thành công")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi: $e")),
        );
      }
    }
  }
}
