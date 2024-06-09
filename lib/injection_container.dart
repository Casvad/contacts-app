import 'package:contacts_app/features/auth/data/data_sources/local/host.dart';
import 'package:contacts_app/features/auth/data/data_sources/local/session.dart';
import 'package:contacts_app/features/auth/data/repository/user_repository.dart';
import 'package:contacts_app/features/auth/domain/repository/user_repository.abs.dart';
import 'package:contacts_app/features/auth/domain/usecases/login.dart';
import 'package:contacts_app/features/auth/domain/usecases/register.dart';
import 'package:contacts_app/features/auth/presentation/cubit/session_cubit.dart';
import 'package:contacts_app/features/contacts/data/repository/contact_repository.dart';
import 'package:contacts_app/features/contacts/domain/repository/contact_repository.abs.dart';
import 'package:contacts_app/features/contacts/domain/usecases/create.dart';
import 'package:contacts_app/features/contacts/domain/usecases/delete.dart';
import 'package:contacts_app/features/contacts/domain/usecases/find.dart';
import 'package:contacts_app/features/contacts/domain/usecases/find_all.dart';
import 'package:contacts_app/features/contacts/domain/usecases/update.dart';
import 'package:contacts_app/features/contacts/presentation/cubit/contact_all_cubit.dart';
import 'package:get_it/get_it.dart';

import 'features/settings/presentation/cubit/host_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Persistence
  sl.registerSingleton<SessionStorage>(SessionStorageImpl());
  sl.registerSingleton<HostStorage>(HostStorageImpl());

  //Repositories
  sl.registerSingleton<UserRepository>(UserRepositoryImpl(sl()));
  sl.registerSingleton<ContactRepository>(ContactRepositoryImpl(sl(), sl()));

  //Use Cases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<RegisterUseCase>(RegisterUseCase(sl()));
  sl.registerSingleton<FindAllContactUseCase>(FindAllContactUseCase(sl()));
  sl.registerSingleton<FindContactByIdUseCase>(FindContactByIdUseCase(sl()));
  sl.registerSingleton<CreateContactUseCase>(CreateContactUseCase(sl()));
  sl.registerSingleton<UpdateContactUseCase>(UpdateContactUseCase(sl()));
  sl.registerSingleton<DeleteContactUseCase>(DeleteContactUseCase(sl()));

  // Cubits
  sl.registerSingleton<SessionCubit>(SessionCubit(sl(), sl(), sl()));
  sl.registerSingleton<ContactAllCubit>(ContactAllCubit(sl(), sl(), sl(), sl(), sl()));
  sl.registerSingleton<HostCubit>(HostCubit(sl()));
}
