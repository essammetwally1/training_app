import 'package:flutter/material.dart';
import 'package:training_app/auth/auth_screen.dart';
import 'package:training_app/onboarding/fade_animation.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  // ignore: library_import 'package:animationloginapp/auth/auth_screen.dart';
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int totalPage = 4;
  int currentPage = 0;
  bool _isLastPage = false;

  void _onScroll() {
    setState(() {
      currentPage = _pageController.page?.round() ?? 0;
      _isLastPage = currentPage == totalPage - 1;
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0)..addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToAuth() {
    Navigator.pushReplacementNamed(context, AuthScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                currentPage = page;
                _isLastPage = page == totalPage - 1;
              });
            },
            children: <Widget>[
              makePage(
                page: 1,
                image: 'assets/images/1.jpg',
                title: 'Cheetah',
                description:
                    "The cheetah is the fastest land animal, capable of reaching speeds up to 60-70 mph. Native to Africa and parts of Iran, it thrives in open grasslands and savannahs, where its incredible speed allows it to chase down prey with precision.",
              ),
              makePage(
                page: 2,
                image: 'assets/images/2.avif',
                title: 'Brown Fox',
                description:
                    "The brown fox is a small to medium-sized, highly adaptable animal found in various habitats around the world. Known for its cunning nature and agility, the brown fox is often recognized by its reddish-brown fur, bushy tail, and sharp, pointed ears.",
              ),
              makePage(
                page: 3,
                image: 'assets/images/3.avif',
                title: 'Wild Deer',
                description:
                    "Wild deer are graceful herbivores commonly found in forests, grasslands, and wetlands. They are known for their agility and keen senses, helping them avoid predators. With antlers that are shed and regrown annually, deer are a symbol of natural beauty and resilience.",
              ),
              makePage(
                page: 4,
                image: 'assets/images/4.avif',
                title: 'Cats',
                description:
                    "Cats are domesticated yet independent animals known for their agility, sharp senses, and affectionate behavior. Their varied coat patterns, expressive eyes, and playful nature make them beloved pets worldwide.",
                isLastPage: true,
              ),
            ],
          ),

          // Skip button (not on last page)
          // if (!_isLastPage)
          //   Positioned(
          //     top: MediaQuery.of(context).padding.top + 20,
          //     right: 20,
          //     child: FadeAnimation(
          //       0.5,
          //       TextButton(
          //         onPressed: _goToAuth,
          //         child: const Text(
          //           'Skip',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 16,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),

          // Page indicator
          Positioned(
            bottom: _isLastPage ? 100 : 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalPage, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.5),
                  ),
                );
              }),
            ),
          ),

          // Get Started Button on last page
          if (_isLastPage)
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: FadeAnimation(
                1.0,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _goToAuth,
                    child: const Text(
                      'GET STARTED',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget makePage({image, title, description, page, bool isLastPage = false}) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            stops: const [0.3, 0.9],
            colors: [
              Colors.black.withValues(alpha: 0.9),
              Colors.black.withValues(alpha: 0.2),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).padding.top + 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  FadeAnimation(
                    0.5,
                    Text(
                      page.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    '/4',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                      0.7,
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          height: 1.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeAnimation(
                      0.9,
                      Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(right: 3),
                            child: const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 15,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 3),
                            child: const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 15,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 3),
                            child: const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 15,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 3),
                            child: const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 15,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: const Icon(
                              Icons.star,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                          const Text(
                            '4.0',
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            '(2300)',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeAnimation(
                      1.1,
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Text(
                          description,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            height: 1.9,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * .1),
                    SizedBox(
                      height: isLastPage
                          ? 60
                          : MediaQuery.of(context).size.height * 0.1,
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
}
