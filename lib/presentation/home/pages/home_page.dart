import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:contact_app/presentation/home/blocs/contact_bloc.dart';
import 'package:contact_app/presentation/home/pages/error_page.dart';
import 'package:contact_app/presentation/home/widgets/contact_list_tile.dart';
import 'package:contact_app/presentation/shared/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = initialPage;

  bool _isLoadingMore = false;

  @override
  void initState() {
    _setupScrollController();
    super.initState();
  }

  void _setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.9) {
        _loadMoreContacts();
      }
    });
  }

  void _loadMoreContacts() {
    final state = context.read<ContactBloc>().state;
    if (!state.isLoading || !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
        _currentPage++;
      });

      _loadContacts();
    }
  }

  void _handleLoadFailure() {
    setState(() {
      _isLoadingMore = false;
      if (_currentPage > initialPage) {
        _currentPage--;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.mes_contacts),
        centerTitle: true,
      ),
      body: BlocConsumer<ContactBloc, ContactState>(
        listener: (context, state) {
          // inspect(state);

          if (state.isLoaded) {
            setState(() {
              _isLoadingMore = false;
            });
          }
          if (state.isFailure && state.contacts.isNotEmpty) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            customSnackBar(context, state.error ?? 'Une erreur est survenue');
            _handleLoadFailure();
          }
        },
        builder: (context, state) {
          // Affiche le loading initial
          if (state.isLoading && state.contacts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Affiche l'erreur initiale
          if (state.isFailure && state.contacts.isEmpty) {
            return ErrorPage(
                title: state.error ?? "Une erreur est survenue",
                onTap: _loadContacts);
          }

          // Affiche la liste des contacts
          return RefreshIndicator(
            onRefresh: () async {
              _refreshContacts();
            },
            child: state.contacts.isEmpty
                ? _emptyContactList()
                : Scrollbar(
                    controller: _scrollController,
                    child: CustomScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              if (index < state.contacts.length) {
                                return ContactListTile(
                                  contact: state.contacts[index],
                                );
                              } else if (!state.hasReachedMax) {
                                return _loadMoreContactsWidget(_isLoadingMore);
                              } else {
                                return const SizedBox();
                              }
                            },
                            childCount: state.contacts.length +
                                (state.hasReachedMax ? 0 : 1),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  _emptyContactList() {
    return const Center(child: Text('Aucun contact disponible'));
  }

  _loadMoreContactsWidget(bool isLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: isLoading
            ? Platform.isIOS
                ? const CupertinoActivityIndicator()
                : const CircularProgressIndicator()
            : const SizedBox(),
      ),
    );
  }

  _refreshContacts() {
    _currentPage = initialPage;
    context.read<ContactBloc>().add(
          RefreshContactsEvent(
            context: context,
            results: contactsPerPage,
          ),
        );
  }

  _loadContacts() {
    context.read<ContactBloc>().add(
          LoadContactsEvent(
            context: context,
            results: contactsPerPage,
            page: _currentPage,
          ),
        );
  }
}
