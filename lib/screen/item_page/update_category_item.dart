import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spend_note/data/model/category_model.dart';
import 'package:spend_note/data/model/tag_model.dart';
import 'package:spend_note/screen/item_page/add_category_item.dart';

class UpdateCategoryItem extends StatefulWidget {
  const UpdateCategoryItem({super.key});

  @override
  State<UpdateCategoryItem> createState() => _UpdateCategoryItemState();
}

class _UpdateCategoryItemState extends State<UpdateCategoryItem> with SingleTickerProviderStateMixin{
  final TextEditingController _searchController = TextEditingController();
  final List<CategoryGroup> chiTienData = [
    CategoryGroup(
      id: "chiTien",
      name: "Ăn uống",
      groupIcon: FontAwesomeIcons.bowlFood,
      color: Colors.blue,
      tags: [
        Tag(name: "Cafe", icon: FontAwesomeIcons.mugHot, color: Colors.orange),
        Tag(
          name: "Ăn tiệm",
          icon: FontAwesomeIcons.plateWheat,
          color: Colors.blueAccent,
        ),
        Tag(
          name: "Ăn sáng",
          icon: FontAwesomeIcons.cakeCandles,
          color: Colors.pinkAccent,
        ),
        Tag(
          name: "Ăn trưa",
          icon: FontAwesomeIcons.bowlRice,
          color: Colors.green,
        ),
        Tag(
          name: "Ăn tối",
          icon: FontAwesomeIcons.utensils,
          color: Colors.deepOrange,
        ),
        Tag(
          name: "Đi chợ/siêu thị",
          icon: FontAwesomeIcons.bagShopping,
          color: Colors.red,
        ),
      ],
      type: "Food",
    ),
    CategoryGroup(
      id: "dichvusinhhoat",
      name: "Dịch vụ sinh hoạt",
      groupIcon: FontAwesomeIcons.house,
      color: Colors.blue,
      tags: [
        Tag(name: "Internet", icon: FontAwesomeIcons.wifi, color: Colors.blue),
        Tag(name: "Nước", icon: FontAwesomeIcons.droplet, color: Colors.cyan),
        Tag(name: "Điện", icon: FontAwesomeIcons.bolt, color: Colors.orange),
        Tag(
          name: "Điện thoại",
          icon: FontAwesomeIcons.mobileScreen,
          color: Colors.blueGrey,
        ),
        Tag(name: "Gas", icon: FontAwesomeIcons.fire, color: Colors.red),
        Tag(
          name: "Thuê người",
          icon: FontAwesomeIcons.broom,
          color: Colors.purple,
        ),
        Tag(
          name: "Truyền hình",
          icon: FontAwesomeIcons.tv,
          color: Colors.amber,
        ),
      ],
      type: "Routine",
    ),
  ];
  final List<Tag> thuTienData = [
    Tag(
      name: "Lương",
      icon: FontAwesomeIcons.moneyCheckDollar,
      color: Colors.greenAccent,
    ),
    Tag(
      name: "Thưởng",
      icon: FontAwesomeIcons.idBadge,
      color: Colors.yellowAccent,
    ),
    Tag(
      name: "Lãi tiết kiệm",
      icon: FontAwesomeIcons.piggyBank,
      color: Colors.pinkAccent,
    ),
    Tag(
      name: "Tiền lãi",
      icon: FontAwesomeIcons.moneyBill,
      color: Colors.blueAccent,
    ),
    Tag(
      name: "Tiền vào",
      icon: FontAwesomeIcons.moneyCheck,
      color: Colors.orangeAccent,
    ),
    Tag(
      name: "Được cho/tặng",
      icon: FontAwesomeIcons.handBackFist,
      color: Colors.yellowAccent,
    ),
    Tag(
      name: "Khác",
      icon: FontAwesomeIcons.moneyBillTransfer,
      color: Colors.yellow,
    ),
  ];
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "Chỉnh sửa hạng mục",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blueAccent,
          labelColor: Colors.blueAccent,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          tabs: [
            Tab(text: "Mục chi"),
            Tab(text: "Mục thu"),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Tìm kiếm theo tên hạng mục",
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[700],
                ),
                prefixIcon: Icon(Icons.search, size: 16.sp),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCategoryChiTienList(chiTienData),
                _buildCategoryThuTienList(thuTienData)
              ],
            ),
          )
        ],
      ),
      floatingActionButton: IconButton(
          onPressed: (){
            String title = "";
            if (_tabController.index == 0) {
              title = "Thêm hạng mục chi";
            } else {
              title = "Thêm hạng mục thu";
            }

            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCategoryItem(titleHeader: title),));
          },
          icon: FaIcon(FontAwesomeIcons.plus, size: 16.sp, color: Colors.white,),
          color: Colors.blueAccent,
          iconSize: 16.sp,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
      ),
    );
  }

  Widget _buildCategoryThuTienList(List<Tag> tags) {
    return ListView.builder(
      itemCount: tags.length,
      itemBuilder: (context, index) {
        final tag = tags[index];
        return Container(
          margin: EdgeInsets.only(top: 10.h),
          color: Colors.white,
          child: ListTile(
            leading: Container(
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                color: tag.color.withOpacity(0.1),
                shape: BoxShape.circle,
                ),
              child: FaIcon(tag.icon, size: 20.sp, color: tag.color),
              ),
            title: Text(
              tag.name,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold,color: Colors.blue[700]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
            ),
        );
      },
    );
  }

  Widget _buildCategoryChiTienList(List<CategoryGroup> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Container(
          margin: EdgeInsets.only(top: 10.h),
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Row(
                  children: [
                    FaIcon(category.groupIcon, color: category.color, size: 20.sp),
                    SizedBox(width: 10.w),
                    Text(
                      category.name,
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold,color: Colors.blue[700]),
                    )
                  ],
                ),
              ),
              const Divider(height: 1),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Tắt cuộn của GridView
                padding: EdgeInsets.all(15.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 0.8,
                ),
                itemCount: category.tags.length,
                itemBuilder: (context, index) {
                  final tag = category.tags[index];
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: tag.color.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: FaIcon(tag.icon, size: 20.sp, color: tag.color),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        tag.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
