import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user/user_profile.dart';
import '../../../gathrfi_app_di.dart';
import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../../../shared/utils/debounce.dart';
import '../../../shared/widgets/global_blur_backdrop.dart';
import '../../../shared/widgets/global_divider.dart';
import '../../../shared/widgets/global_label_wrapper.dart';
import '../managers/profile_search_bloc.dart';

class ProfileSearchField extends StatefulWidget {
  const ProfileSearchField({super.key, this.label, required this.onPicked});

  final String? label;
  final Function(UserProfile? profile) onPicked;

  @override
  State<ProfileSearchField> createState() => _ProfileSearchFieldState();
}

class _ProfileSearchFieldState extends State<ProfileSearchField> {
  late final GlobalKey<FormState> _formKey;
  late final ProfileSearchBloc _profileSearchBloc;
  final _searchController = TextEditingController();
  final _debounce = Debounce(milliseconds: 500);
  final _layerLink = LayerLink();
  bool _isDropdownOpen = false;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _profileSearchBloc = locator<ProfileSearchBloc>();
    super.initState();
  }

  void _openDropdown() {
    if (_isDropdownOpen) return;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _isDropdownOpen = true;
  }

  void _closeDropdown() {
    if (!_isDropdownOpen) return;
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isDropdownOpen = false;
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject()! as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeDropdown,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height - context.spacingMd),
              child: Material(
                elevation: 0.0,
                color: Colors.transparent,
                borderRadius: context.spacingMd.borderRadius,
                child: GlobalBlurBackdrop(
                  color: switch (context.brightness) {
                    Brightness.light => Colors.grey.shade100,
                    Brightness.dark => Colors.grey.shade900,
                  },
                  borderRadius: context.spacingSm.borderRadius,
                  child: BlocProvider.value(
                    value: _profileSearchBloc,
                    child: BlocBuilder<ProfileSearchBloc, ProfileSearchState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return Padding(
                              padding: EdgeInsets.all(context.spacingMd),
                              child: Text(context.l10n.searching),
                            );
                          },
                          loaded: (profiles, selectedProfile) {
                            return _ResultListView(profiles: profiles);
                          },
                          error: (message) => const SizedBox.shrink(),
                        );
                      },
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

  @override
  void dispose() {
    _searchController.dispose();
    _debounce.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileSearchBloc>(
      create: (context) => _profileSearchBloc,
      child: BlocConsumer<ProfileSearchBloc, ProfileSearchState>(
        listener: (context, state) {
          state.whenOrNull(
            loading: () => _openDropdown(),
            loaded: (profiles, selectedProfile) {
              if (selectedProfile != null) {
                FocusManager.instance.primaryFocus?.unfocus();
                _searchController.clear();
                widget.onPicked(selectedProfile);
                _closeDropdown();
              }
            },
            initial: () {
              _searchController.clear();
              widget.onPicked(null);
              _closeDropdown();
            },
          );
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: GlobalLabelWrapper(
              label: widget.label ?? context.l10n.iGroupMembersLabel,
              child: CompositedTransformTarget(
                link: _layerLink,
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: context.l10n.iGroupMembersHint,
                    suffixIcon: ValueListenableBuilder(
                      valueListenable: _searchController,
                      builder: (context, value, child) {
                        return value.text.isEmpty
                            ? const SizedBox.shrink()
                            : IconButton(
                                onPressed: () => _searchController.clear(),
                                icon: Assets.icons.icCross.icon(context),
                              );
                      },
                    ),
                  ),
                  onChanged: (query) => _debounce.run(
                    () => _profileSearchBloc.add(
                      ProfileSearchEvent.search(query),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ResultListView extends StatelessWidget {
  const _ResultListView({required this.profiles});
  final List<UserProfile> profiles;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: profiles.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final profile = profiles[index];
        return ListTile(
          onTap: () {
            context.read<ProfileSearchBloc>().add(
              ProfileSearchEvent.select(index),
            );
          },
          title: Text(profile.username.orDefault),
          leading: ClipOval(
            child: CachedNetworkImage(
              imageUrl: profile.image.orEmpty,
              height: context.spacingLg * 2,
              width: context.spacingLg * 2,
              errorListener: (value) => log(value.toString()),
              errorWidget: (context, url, error) {
                return Padding(
                  padding: EdgeInsets.all(context.spacingXxs / 2),
                  child: Assets.icons.icUser.icon(
                    context,
                    color: ColorName.textSecondary,
                  ),
                );
              },
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const GlobalDivider();
      },
    );
  }
}
