import 'package:factos/feature/home/presentation/screens_home_barrel.dart';

class HeaderWidget extends ConsumerWidget {
  HeaderWidget({super.key, required this.height, required this.isResultSearch});

  final double height;
  bool isResultSearch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchProvider);
    final searchFactos = ref.read(searchFactosProvider);

    final isSearchBar = ref.watch(isSearchBarBoolean);

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 15, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Explorar',
              style: TextStyle(
                  height: 1.2,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Busca cualquier facto por palabra clave',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                height: 1.2,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.015,
          ),
          Container(
            height: height * 0.05,
            decoration: BoxDecoration(
              color: searchFieldBackgroundColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SearchScreen()));
                    },
                    icon: const Icon(
                      size: 28,
                      Icons.search,
                      color: Colors.grey,
                    )),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        ref.read(isSearchBarBoolean.notifier).state = true;
                        ref.read(titleSearchedFactoProvider.notifier).state =
                            value;
                      }

                      isResultSearch = true;
                      searchFactos(value);
                    },
                    style: const TextStyle(
                        color: Colors.white, fontFamily: 'Inter'),
                    decoration: const InputDecoration(
                      hintText: 'Python',
                      hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontFamily: 'Inter'),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
