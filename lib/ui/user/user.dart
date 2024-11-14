import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserTab extends StatefulWidget {
  const UserTab({super.key});

  @override
  State<UserTab> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  bool isEnable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            width: double.infinity,
            height: 264,
            child: Stack(
              children: [
                Image.asset(
                  'assets/profileBackground.png',
                  width: double.infinity,
                  height: 264,
                  fit: BoxFit.cover,
                ),
                SafeArea(
                  top: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                debugPrint('CLICK');
                                // Navigator.of(context).pop();
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(999),
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 0.2),
                                  child: Center(
                                    child: Transform.translate(
                                      offset: const Offset(-2, 0),
                                      child: SvgPicture.asset(
                                        'assets/svg/ic_back.svg',
                                        width: 24,
                                        height: 24,
                                        color: const Color(0xffFFFFFF),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 22,
                                height: 1.5,
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                width: 68,
                                height: 68,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 0.83),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                padding: const EdgeInsets.all(1.5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(999),
                                  child: SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Image.asset(
                                        'assets/defaultAvatar.png',
                                        width: double.infinity,
                                        height: double.infinity,
                                      )),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            'Trung Hoàng',
                                            style: TextStyle(
                                              fontSize: 20,
                                              height: 1,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            debugPrint('EDIT BUTTON PRESS');
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/ic_edit.svg',
                                                width: 18,
                                                height: 18,
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 0.8),
                                              ),
                                              const SizedBox(width: 6),
                                              const Text(
                                                'Sửa thông tin',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 0.8),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Nam | 12/10/1994',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1.5,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.8),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 219,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              // transform: Matrix4.translationValues(0, -45, 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cài đặt',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(113, 120, 134, 1),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RowItem(
                    leftIcon: 'assets/svg/ic_faceid.svg',
                    label: 'Face ID',
                    disable: true,
                    rightView: Switch(
                      value: isEnable,
                      thumbColor: const WidgetStatePropertyAll(Colors.white),
                      activeTrackColor: const Color.fromRGBO(104, 70, 239, 1),
                      inactiveThumbColor: Colors.grey,
                      trackOutlineWidth: const WidgetStatePropertyAll(0),
                      trackOutlineColor: const WidgetStatePropertyAll(
                          Color.fromRGBO(0, 0, 0, 0)),
                      onChanged: (val) {
                        setState(() {
                          isEnable = val;
                        });
                      },
                    ),
                  ),
                  RowItem(
                    leftIcon: 'assets/svg/ic_password.svg',
                    label: 'Thay đổi mật khẩu',
                    onPress: () {
                      debugPrint('CHANGE PASSWORD ROW PRESSED');
                    },
                  ),
                  const RowItem(
                    leftIcon: 'assets/svg/ic_phone.svg',
                    label: 'Thay đổi số điện thoại',
                  ),
                  const RowItem(
                    leftIcon: 'assets/svg/ic_event.svg',
                    label: 'Sự kiện đã lưu',
                  ),
                  const RowItem(
                    leftIcon: 'assets/svg/ic_logout.svg',
                    label: 'Đăng xuất',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  const RowItem({
    super.key,
    required this.leftIcon,
    required this.label,
    this.rightView,
    this.disable = false,
    this.onPress,
  });
  final String leftIcon;
  final String label;
  final Widget? rightView;
  final bool disable;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (disable) return;
          debugPrint('ITEM PRESS');
          onPress?.call();
        },
        child: Container(
          height: 55,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  width: 1, color: Color.fromRGBO(204, 204, 204, 0.5)),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                leftIcon,
                width: 24,
                height: 24,
                color: const Color.fromRGBO(113, 120, 134, 1),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    inherit: false,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(21, 20, 31, 1),
                    fontFamily: 'Manrope',
                  ),
                ),
              ),
              rightView != null
                  ? rightView!
                  : Transform.rotate(
                      angle: 3.14159,
                      child: SvgPicture.asset(
                        'assets/svg/ic_back.svg',
                        width: 20,
                        height: 20,
                        color: const Color.fromRGBO(113, 120, 134, 1),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
