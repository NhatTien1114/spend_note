import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spend_note/auth/screen/signin_screen.dart';
import 'package:spend_note/auth/services/google_auth.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
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
                    Text(
                      "Đăng nhập tài khoản",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Email hoặc số điện thoại",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                        hoverColor: Color(0xFF01AEF0),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16.h),
                    TextField(
                      controller: _passController,
                      obscureText: true,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Mật khẩu",
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                        hoverColor: Color(0xFF01AEF0),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Quên mật khẩu",
                            style: TextStyle(color: Colors.blueAccent, fontSize: 16)),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 35.h,
                      child: ElevatedButton(
                        onPressed: () {
                          print("Login click: ${_emailController.text}");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text("Đăng nhập",
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Bạn chưa có tài khoản?", style: TextStyle(fontSize: 15.sp, color: Colors.grey[600]),),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SigninScreen(),));
                          },
                          child: Text(
                            "Đăng ký",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp
                            ),
                          ),
                        )
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
                          onTap: () async {
                            try {
                              final userCredential = await GoogleSignInService.signInWithGoogle();
                              if (userCredential != null) {
                                print("Đăng nhập thành công: ${userCredential.user?.displayName}");
                              }
                            } catch (e) {
                              print("Lỗi đăng nhập Google: $e");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Đăng nhập thất bại: $e")),
                              );
                            }
                          },
                        ),
                        SizedBox(width: 10.w),
                        _buildSocialButton(
                          icon: FontAwesomeIcons.facebook,
                          color: const Color(0xFF4267B2),
                          onTap: () => print("Facebook Login"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
        child: FaIcon(icon, color: color, size: 20.sp),
      ),
    );
  }
}