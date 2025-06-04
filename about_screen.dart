import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/app_drawer.dart';


class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  final String _appVersion = "1.0.0";

  Future<void> _launchURL(BuildContext context, String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $urlString');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open link: $urlString'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary, size: 28),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            Divider(
              height: 24,
              thickness: theme.dividerTheme.thickness,
              color: theme.dividerTheme.color,
            ),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // --- USER CONFIGURABLE VALUES ---
    const String githubRepoUrl = "https://github.com/Danishf1007/Mobile-Assignment";
    const String authorName = "WAN MUHAMMAD DANISH AIMAN BIN WAN MOHD NAZIM";
    const String matricNo = "2023516353";
    const String courseName = "NETCENTRIC COMPUTING";
    const String copyrightHolderName = "WAN MUHAMMAD DANISH AIMAN";
    // --- END USER CONFIGURABLE VALUES ---

    return Scaffold(

      appBar: AppBar(
        title: const Text('About This App'),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Application Icon
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                'assets/images/dividend_logo2.png',
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.broken_image_outlined,
                    size: 80,
                    color: theme.colorScheme.onSurface.withOpacity(0.3), // Use onSurface
                  );
                },
              ),
            ),
            const SizedBox(height: 16), // Increased spacing
            Text(
              'Dividend Calculator App',
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'Version $_appVersion',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6), // Use onSurface
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28), // Increased spacing

            _buildSectionCard(
              context: context,
              icon: Icons.person_pin_rounded,
              title: 'Author Information',
              children: [
                ListTile(
                  leading: Icon(Icons.account_circle_outlined, color: theme.iconTheme.color),
                  title: Text('Name', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  subtitle: Text(authorName, style: theme.textTheme.bodyMedium),
                ),
                ListTile(
                  leading: Icon(Icons.pin_outlined, color: theme.iconTheme.color),
                  title: Text('Matric No', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  subtitle: Text(matricNo, style: theme.textTheme.bodyMedium),
                ),
                ListTile(
                  leading: Icon(Icons.school_outlined, color: theme.iconTheme.color),
                  title: Text('Course', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  subtitle: Text(courseName, style: theme.textTheme.bodyMedium),
                ),
              ],
            ),

            _buildSectionCard(
              context: context,
              icon: Icons.copyright_rounded,
              title: 'Copyright Notice',
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  child: Text(
                    '© ${DateTime.now().year} $copyrightHolderName. All Rights Reserved.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),

            _buildSectionCard(
              context: context,
              icon: Icons.code_rounded,
              title: 'Source Code',
              children: [
                Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => _launchURL(context, githubRepoUrl),
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                          child: Text(
                            'View on GitHub',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: theme.colorScheme.primary,
                              // fontWeight is handled by labelLarge from theme
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        githubRepoUrl,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}