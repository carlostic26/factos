import 'package:factos/config/styles/constants/theme_data.dart';
import 'package:factos/presentation/provider/riverpod.dart';
import 'package:factos/presentation/screens/home/home_screen.dart';
import 'package:factos/presentation/screens/welcome/widgets/welcome_first_page.dart';
import 'package:factos/presentation/screens/welcome/widgets/welcome_fourth_widget.dart';
import 'package:factos/presentation/screens/welcome/widgets/welcome_second_page.dart';
import 'package:factos/presentation/screens/welcome/widgets/welcome_third_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = PageController();
    final currentPage = ref.watch(pageProvider);

    return Scaffold(
      backgroundColor: scaffoldBackgroundGlobalColor,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (int page) {
                ref.read(pageProvider.notifier).setPage(page);
              },
              children: const [
                WelcomeFirstPage(),
                WelcomeSecondPage(),
                WelcomeThirdPage(),
                WelcomeFourthPage(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 10),
              child: currentPage == 3
                  ? TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(buttonLigthColor),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomeScreen()));

                        // TODO: Save preferences

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Preferencias guardadas'),
                          ),
                        );
                      },
                      child: const Text(
                        'Guardar',
                        style: TextStyle(color: lightBackgroundTextColor),
                      ),
                    )
                  : IconButton(
                      iconSize: 30,
                      onPressed: () {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const SizedBox(height: 70, child: Placeholder()),
    );
  }
}
