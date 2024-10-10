import 'package:factos/core/config/ads/ads_factos.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ApoyaApp extends StatefulWidget {
  const ApoyaApp({super.key});

  @override
  State<ApoyaApp> createState() => _ApoyaAppState();
}

const int maxAttempts = 5;

class _ApoyaAppState extends State<ApoyaApp> {
  //initializing reward ad
  RewardedAd? rewardedAd;
  int rewardedAdAttempts = 0;
  int enterAcces = 0;
  bool isRewardedShowed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    createRewardedAd();
  }

  static const AdRequest request = AdRequest(
      //keywords: ['',''],
      //contentUrl: '',
      //nonPersonalizedAds: false
      );

  FactosAds ads = FactosAds();

  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: ads.rewardedAd,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          rewardedAd = ad;
          rewardedAdAttempts = 0;
        }, onAdFailedToLoad: (error) {
          rewardedAdAttempts++;
          rewardedAd = null;
          if (rewardedAdAttempts <= maxAttempts) {
            createRewardedAd();
          }
        }));
  }

  void showRewardedAd() {
    if (rewardedAd == null) {
      if (enterAcces <= 2) {
        Fluttertoast.showToast(
          msg: "Intenta de nuevo",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        createRewardedAd();
      } else if (enterAcces > 2 && enterAcces <= 3) {
        Fluttertoast.showToast(
          msg: "Tu telefono no cargó el anuncio.\nVuelve a intentarlo.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        createRewardedAd();
      } else if (enterAcces > 3) {
        showRewardedAd();
      }

      return;
    }

    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(

        //when ad closes
        onAdDismissedFullScreenContent: (ad) async {
      setState(() {
        isRewardedShowed = true;
      });
      Fluttertoast.showToast(
        msg: "¡Gracias por tu apoyo!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      ad.dispose();
      createRewardedAd();
    });

    rewardedAd!.show(onUserEarnedReward: (ad, reward) {
      // print('reward video ${reward.amount} ${reward.type}');
    });
    rewardedAd = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Apóyanos',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Con tu ayuda podemos aumentar la cantidad de Factos de Programación para que te enteres de todos los datos relacionados a tu sector Tech. Te tomará solo unos segundos.',
              style: TextStyle(fontFamily: 'Inter'),
            ),
            const SizedBox(
              height: 10,
            ),
            isRewardedShowed
                ? SizedBox(
                    height: 270,
                    width: 370,
                    child: Image.network(
                        fit: BoxFit.fill,
                        'https://media3.giphy.com/media/FPF3LQS9qAYxyEHSql/200w.gif?cid=6c09b952ljxvmu5lsaiztlds24oqfakwbouu3wyovgu2gcxz&ep=v1_videos_related&rid=200w.gif&ct=v'),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 50,
            ),
            TextButton(
                onPressed: () {
                  showRewardedAd();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const SizedBox(
                    width: 180,
                    height: 30,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.visibility,
                            color: Colors.white,
                          ),
                          Text(
                            '  Ver un anuncio',
                            style: TextStyle(color: Colors.white),
                          )
                        ]),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
