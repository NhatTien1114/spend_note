import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spend_note/auth/screen/auth_screen/login_screen.dart';
import 'package:spend_note/auth/services/auth.dart';
import 'package:spend_note/auth/services/google_auth.dart';
import 'package:spend_note/util/snack_bar.dart';

class SigninScreen extends StatefulWidget {
  final VoidCallback show;
  const SigninScreen(this.show ,{super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _passConfirmController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isObscure = true;
  bool _isObscureConfirm = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _passConfirmController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "image/login-banner.png",
                width: double.infinity,
                height: 150.h,
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    Text("Đăng ký tài khoản",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.sp,
                          color: Colors.black)
                    ),
                    SizedBox(height: 16.h,),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                        hoverColor: Color(0xFF01AEF0),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16.h,),
                    TextField(
                      controller: _passController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Mật khẩu",
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: Icon(_isObscure ? Icons.remove_red_eye_outlined
                                : Icons.visibility_off_outlined,
                            )),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                        hoverColor: Color(0xFF01AEF0),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 16.h,),
                    TextField(
                      controller: _passConfirmController,
                      obscureText: _isObscureConfirm,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Xác nhận mật khẩu",
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscureConfirm = !_isObscureConfirm;
                              });
                            },
                            icon: Icon(_isObscureConfirm ? Icons.remove_red_eye_outlined
                                : Icons.visibility_off_outlined,
                            )
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                        hoverColor: Color(0xFF01AEF0),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 16.h,),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Tên của bạn",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                        hoverColor: Color(0xFF01AEF0),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 16.h,),
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                              children: [
                                const TextSpan(text: "Bằng cách bấm vào nút đăng ký, bạn đã đồng ý với "),
                                TextSpan(
                                  text: "Điều khoản & Chính sách",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                const TextSpan(text: " của chúng tôi."),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16.h,),
                    SizedBox(
                      width: double.infinity,
                      height: 35.h,
                      child: ElevatedButton(
                        onPressed: () async{
                          try {
                            await Authentication().Singin(
                              email: _emailController.text,
                              password: _passController.text,
                              passwordConfirm: _passConfirmController.text,
                              name: _nameController.text,
                            );
                            AppSnackbar.showSuccess(context, "Thành công", "Đăng ký thành công");
                            widget.show();
                          } catch (e) {
                            AppSnackbar.showError(context, "Lỗi", "Đăng nhập thất bại");
                            print("Lỗi đăng ký: $e");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text("Đăng ký",
                            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Bạn đã có tài khoản?", style: TextStyle(fontSize: 15.sp, color: Colors.grey[600]),),
                        TextButton(
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder:(context) => LoginScreen(widget.show)));
                            },
                            child: Text("Đăng nhập ngay", style: TextStyle(color: Colors.blueAccent, fontSize: 16.sp),))
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            "Hoặc đăng nhập bằng",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                            icon: FontAwesomeIcons.google,
                            color: const Color(0xFFDB4437),
                            onTap: () async{
                              try {
                                final userCredential = await GoogleSignInService.signInWithGoogle();
                                if (userCredential != null) {
                                  print("Đăng nhập thành công: ${userCredential.user?.displayName}");
                                }
                              } catch (e) {
                                print("Lỗi $e");
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đăng nhập thất bại: $e"),));
                              }
                            }),
                        SizedBox(width: 10.w),
                        _buildSocialButton(
                            icon: FontAwesomeIcons.facebook,
                            color: const Color(0xFF4267B2),
                            onTap: (){}),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  Widget _buildSocialButton({required IconData icon, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: FaIcon(
          icon, color: color, size: 20.sp,
        ),
      ),
    );
  }
}
