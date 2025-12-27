import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_shared_app/src/core/constants/constants.dart';

import 'package:qr_shared_app/src/core/services/services.dart';
import 'package:qr_shared_app/src/features/home/widgets/contact.dart';
import 'package:qr_shared_app/src/features/home/widgets/disclaimer.dart';
import 'package:qr_shared_app/src/features/home/widgets/text_section.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoContent extends StatelessWidget {
  const InfoContent({super.key});

  Future<void> _sendEmail(String email) async {
    final emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Compartir QR Feedback', // Asunto sugerido
        'body': 'Hola, tengo una sugerencia/problema: ', // Cuerpo sugerido
      },
    );

    try {
      final launched = await launchUrl(
        emailLaunchUri,
        mode: LaunchMode.externalNonBrowserApplication,
      );
      if (!launched) {
        SnackbarService.show(MessageConstants.errorOpenMail);
      }
    } on PlatformException catch (e) {
      SnackbarService.show(
        MessageConstants.systemError,
      );
      debugPrint('Error de plataforma: ${e.message}');
    } on Exception catch (e) {
      SnackbarService.show(MessageConstants.noMailAccount);
      debugPrint('Error genérico: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: DraggableScrollableSheet(
        initialChildSize: .6,
        maxChildSize: .9,
        minChildSize: .4,
        expand: false,
        builder: (context, scrollController) {
          return ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Text(
                StringConstants.useGuide,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              const SizedBox(height: 20),
              ...InformationContent.sections.map(
                (section) => TextSection(
                  title: section.title,
                  content: section.content,
                ),
              ),
              const SizedBox(height: 10),
              const Disclaimer(),
              const SizedBox(height: 10),
              Contact(onPress: () => _sendEmail(StringConstants.authorEmail)),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
