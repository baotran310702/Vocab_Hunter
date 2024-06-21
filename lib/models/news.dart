import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String title;
  final String content;
  final String source;
  final String authors;
  final String urlToImage;
  final DateTime publishedAt;

  // Constructor
  const News({
    required this.title,
    required this.content,
    required this.source,
    required this.authors,
    required this.urlToImage,
    required this.publishedAt,
  });

  // From JSON
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? "",
      content: json['content'] ?? "",
      source: json['source'] ?? "",
      authors: json['authors'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : DateTime.now(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'source': source,
      'authors': authors,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.toIso8601String(),
    };
  }

  // Copy With
  News copyWith({
    String? title,
    String? content,
    String? source,
    String? authors,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
  }) {
    return News(
      title: title ?? this.title,
      content: content ?? this.content,
      source: source ?? this.source,
      authors: authors ?? this.authors,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }

  static List<News> defaultNews = [
    News(
      title:
          "Spain vs. Italy highlights: Spain wins Euro 2024 showdown with own goal, score",
      content:
          "Spain beat Italy 1-0 on Thursday in the teams’ second group stage match of Euro 2024, the only score being an own-goal despite Spain’s dominance throughout the game.\n Italy goalkeeper Gianluigi Donnarumma made eight saves in the loss, but he couldn’t keep out a second-half deflection off defender Riccardo Calafiori.\n The win clinched Spain a spot in the knockout round, while Italy will face Croatia in the final group game hoping to secure a spot in the last 16.\"We are angry,\" Donnarumma said after the game. \"Let's use this to motivate ourselves for the next games, our destiny is in our hands.\"",
      source: "USA Today",
      authors: "Jesse YomTov",
      urlToImage:
          "https://i.ytimg.com/vi/u5nYscbBgdU/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLCwURxBKYGK3h0BLLuEpNvVEeyHJQ",
      publishedAt: DateTime(2024, 06, 21, 11, 30),
    ),
    News(
      title:
          "German minister's visit a chance to defuse trade tensions, China state media say",
      content:
          "BEIJING (Reuters) - The German economy minister's visit to China this week will be an opportunity for Europe's biggest economy to seek consensus rather than confrontation, Chinese state media said, amid trade tensions with the European Union over electric vehicles.\n Germany Economy Minister Robert Habeck will arrive in Beijing on Friday as the European Commission moves to place hefty tariffs on imports of Chinese-made electric vehicles, unleashing countermeasures by China and harsh criticism from Chinese leaders. \nThis week alone, Chinese automakers urged Beijing to hike tariffs on imported European gasoline-powered cars in retaliation for Brussels' move. The three-day visit is seen as an opportunity for Germany to seek consensus, some experts said, according to Chinese state-controlled tabloid Global Times. \"If Germany can resolve potential trade conflicts between China and the EU without confrontation, it could provide a new model for global economic order and governance, especially at a time when Europe is facing multiple conflicts,\" an expert was quoted as saying by Global Times. Habeck, who has personally spoken out against punitive tariffs as a last resort, had said \"China is an indispensable partner for global challenges\".\nRelations with China had become more complex but the world's second-largest economy was an important partner in all fields, Chinese state media cited him as saying. Immediately upon his arrival in Beijing, Habeck is expected to meet with ambassadors of several EU countries and then head into talks with Premier Li Qiang and other officials. He will also meet Industry Minister Jin Zhuanglong and Commerce Minister Wang Wentao before going to Shanghai and Hangzhou.",
      source: "Investing - Economy",
      authors: "Bernard Orr",
      urlToImage:
          "https://i-invdn-com.investing.com/trkd-images/LYNXMPEK5K02D_L.jpg",
      publishedAt: DateTime(2024, 06, 20, 20, 37),
    ),
    News(
      title:
          "Putin and Kim seen laughing in Russian-made limousine after inking mutual defense pact",
      content:
          "In footage released by North Korean state media agency KCNA on Thursday, the two autocrats appear to enjoy each other’s company as they take a jaunt in the Aurus luxury car. The carefully-choreographed moment shows Putin taking a turn in the driving seat first while Kim sits in the passenger seat, before the two swap places. \nThe images are designed to highlight the close bond between the leaders, who say they have ramped up ties to a “new level” during the Russian president’s rare visit to the reclusive state this week. \nNorth Korea and Russia inked a new defense pact during the visit, pledging to use all available means to provide immediate military assistance in the event the other is attacked. \nThe pact, which comes against the backdrop of Putin’s grinding war against Ukraine, is the most significant agreement signed by Russia and North Korea in decades and is seen as something of a revival of their 1961 Cold War-era mutual defense pledge. It also consolidates the Kim regime’s powerful link with a world power that wields a veto on the UN Security Council.\nOn Wednesday, Putin presented Kim with an Aurus car as the pair exchanged gifts, according to Russian state media – the second time the Kremlin leader has given his counterpart this car model. According to Putin’s aide Yuri Ushakov, the Russian leader also presented Kim with a tea set.\n",
      source: "CNN",
      authors: "John Doji",
      urlToImage:
          "https://media.cnn.com/api/v1/images/stellar/prod/2024-06-20t025828z-1349399794-rc2qe8a6q5zl-rtrmadp-3-northkorea-russia.JPG?c=16x9&q=h_653,w_1160,c_fill/f_webp",
      publishedAt: DateTime(2024, 06, 20, 8, 22),
    ),
    News(
      title: "The digital dermatologist will see you now",
      content:
          "CNN — Not so long ago, seeing a dermatologist was only deemed necessary if you had skin problems or possessed a famous face to be pored over in magazines or on the big screen.\n Not anymore. Whether it’s due to the rise of social media or celebrity culture, the past decade has seen our quest for apparently flawless skin go up a gear. A recent study found Gen Z spend more cash on their skin than any other age group (and more than previous generations). And in 2023 alone, spending on skincare by tweens and teens  leapt 20%.\nTechnology has also made getting expert advice increasingly achievable, too. Online dermatology developed quickly during the pandemic when Covid-19 restrictions meant that over 90% of dermatologists were using “teledermatology” (e.g. video calls and digital images to discuss skin concerns remotely) compared to 14.1% pre-Covid, said the American Academy of Dermatology.\n The advent of digital dermatology, pushed forward by increasingly innovative and sophisticated digital tools — not only smartphones and video calling apps but artificial intelligence — is enabling a growing number of global brands to diagnose, prescribe and produce bespoke creams via virtual consultation rooms. It’s dermatology without the wait list, minus the travel and, somewhat ironically, without the need for a face-to-face interaction. But is it any good?",
      source: "CNN",
      authors: "John Doji",
      urlToImage:
          "https://media.cnn.com/api/v1/images/stellar/prod/artboard-1-copy-2.png?q=w_2000,c_fill/f_webp",
      publishedAt: DateTime(2024, 06, 20, 8, 22),
    ),
  ];

  @override
  List<Object?> get props => [
        title,
        content,
        source,
        authors,
        urlToImage,
        publishedAt,
      ];
}
