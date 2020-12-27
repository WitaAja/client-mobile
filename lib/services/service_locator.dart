import 'package:get_it/get_it.dart';
import 'package:wisata_aja/repositories/auth_repository.dart';
import 'package:wisata_aja/repositories/posting.dart';
import 'package:wisata_aja/repositories/profile_repository.dart';
import 'package:wisata_aja/repositories/region_repositories.dart';
import 'package:wisata_aja/utils/api_client/afterware.dart';
import 'package:wisata_aja/utils/api_client/api_client.dart';
import 'package:wisata_aja/utils/api_client/middleware.dart';

GetIt sl = GetIt.instance;

void setUpLocators() {
  sl.registerSingleton<ApiClient>(ApiClient(middleWares: [CacheMiddleware()], afterWares: [TokenExpiredAfterWare(), ResponseErrorDialogAfterWare()]));

  ///  REPOSITORIES
  sl.registerSingleton<AuthRepositories>(AuthRepositories());
  sl.registerSingleton<ProfileRepositories>(ProfileRepositories());
  sl.registerSingleton<RegionRepositories>(RegionRepositories());
  sl.registerSingleton<PostingRepositories>(PostingRepositories());
}
