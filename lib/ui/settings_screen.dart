import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:auth/prefs.dart';
import 'package:auth/top_bar.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with WidgetsBindingObserver {
  late final List<List<dynamic>> options = [
    [Prefs.biometricUnlock, '生物识别解锁'],
    [Prefs.isShowCaptchaOnTap, '轻触显示验证码'],
    [Prefs.isCopyCaptchaOnTap, '轻触复制验证码'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(context, '设置'),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 700, mainAxisSpacing: 16, crossAxisSpacing: 16, mainAxisExtent: 90),
        itemCount: options.length,
        itemBuilder: (BuildContext context, int index) {
          final List<dynamic> option = options[index];
          return _Button(option[0] as Signal<bool>, option[1] as String, key: ObjectKey(option));
        },
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button(this.enable, this.label, {super.key});

  final Signal<bool> enable;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: const BorderRadius.all(Radius.circular(24))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(width: 12),
          Expanded(child: Text(label, maxLines: 1, style: TextStyle(height: 0, fontSize: 18, color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold))),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              enable.value = !enable.value;
            },
            child: Watch.builder(
              builder: (context) {
                return Container(
                  height: 48,
                  width: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: enable.value ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.inversePrimary,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Icon(enable.value ? Icons.done : Icons.close, size: 36, color: Theme.of(context).colorScheme.onPrimary),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
