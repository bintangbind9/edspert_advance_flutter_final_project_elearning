import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/styles.dart';
import '../../../domain/entities/event_banner_model.dart';
import '../../bloc/banners/banners_bloc.dart';
import '../../widgets/sub_section.dart';
import 'event_banner_image.dart';

class BannerListHomeScreen extends StatelessWidget {
  const BannerListHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersBloc, BannersState>(
      buildWhen: (previous, current) =>
          (previous is GetBannersLoading && current is GetBannersSuccess) ||
          (previous is GetBannersLoading && current is GetBannersError),
      builder: (context, state) {
        return SubSection(
          title: 'Terbaru',
          horizontalTitlePadding: Styles.mainPadding,
          verticalTitlePadding: Styles.mainPadding,
          child: state is GetBannersError
              ? Text(state.message)
              : (state is GetBannersSuccess
                  ? SizedBox(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.banners.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final EventBanner banner = state.banners[index];
                          return EventBannerImage(banner: banner);
                        },
                      ),
                    )
                  : const CircularProgressIndicator()),
        );
      },
    );
  }
}
