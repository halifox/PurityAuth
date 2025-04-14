import 'package:flutter/material.dart';

void defaultLeftOnPressed(BuildContext context) {
  Navigator.pop(context);
}

PreferredSize TopBar(
  BuildContext context,
  String title, {
  IconData? leftIcon = Icons.arrow_back,
  void Function(BuildContext)? leftOnPressed = defaultLeftOnPressed,
  IconData? rightIcon,
  void Function(BuildContext)? rightOnPressed,
}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(100),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            TopBarIconButton(context, leftIcon, () => leftOnPressed?.call(context)),
            const Spacer(),
            Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
            const Spacer(),
            TopBarIconButton(context, rightIcon, () => rightOnPressed?.call(context)),
          ],
        ),
      ),
    ),
  );
}

/// 创建一个顶部导航栏图标按钮组件。
/// [icon] 图标，类型为 [IconData?]。
/// [onPressed] 点击回调，类型为 [VoidCallback?]。
/// 返回值为图标按钮的 [Widget] 组件。
Widget TopBarIconButton(BuildContext context, IconData? icon, VoidCallback? onPressed) {
  return Visibility(
    visible: icon != null,
    replacement: const SizedBox(width: 64, height: 64),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        fixedSize: const Size(64, 64),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      child: Icon(icon, size: 30, color: Theme.of(context).colorScheme.onPrimaryContainer),
    ),
  );
}
