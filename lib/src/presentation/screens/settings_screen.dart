import 'package:flutter/material.dart';
import 'package:tutor_app/src/presentation/components/appbars/transparent_appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 22),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text(
          "Настройки",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.04,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 66,
                    width: 66,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(360),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFC2D1E5),
                            offset: Offset(0, -1),
                            blurRadius: 11,
                          )
                        ]),
                    child: const Center(
                      child: Image(
                        image: NetworkImage(
                            "https://i.pinimg.com/originals/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg"),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -3,
                    bottom: 3,
                    child: Container(
                      height: 30,
                      width: 30,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(360),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFFC2D1E5),
                              offset: Offset(0, -1),
                              blurRadius: 11,
                            )
                          ]),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                        ),
                        onPressed: () {},
                        splashRadius: 25,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 43),
              titleWithDetailes("Меня зовут", "Имя Фамилие"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 49),
                child: titleWithDetailes("Обо мне", "Расскажите что нибудь"),
              ),
              titleWithDetailes("Email", "uomuraliev09@gmail.com"),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.exit_to_app_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {},
                    splashRadius: 20,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    "Выход",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleWithDetailes(String title, String details) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.04,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            details,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.04,
            ),
          )
        ],
      );
}
