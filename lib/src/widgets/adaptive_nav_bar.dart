import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../models/nav_item.dart';

class AdaptiveNavBar extends StatelessWidget {
  final NavigationController controller;
  final List<NavItem> items;
  final double height;
  final double iconSize;
  final double selectedFontSize;
  final double unselectedFontSize;
  final bool showLabels;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final NotchedShape? notchedShape;
  final double elevation;
  final BorderRadius? borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;

  AdaptiveNavBar({
    Key? key,
    required this.items,
    this.height = 65.0,
    this.iconSize = 24.0,
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.showLabels = true,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.notchedShape,
    this.elevation = 8.0,
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOutCubic,
  })  : controller = Get.put(NavigationController()),
        assert(items.length >= 2, 'At least 2 items are required'),
        assert(items.length <= 5, 'Maximum 5 items are allowed'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBgColor = theme.brightness == Brightness.light
        ? Colors.white
        : theme.colorScheme.surface;

    return Container(
      margin: const EdgeInsets.all(12),
      child: Material(
        elevation: elevation,
        borderRadius: borderRadius ?? BorderRadius.circular(24),
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ColorFilter.mode(
              Colors.black.withOpacity(0.1),
              BlendMode.srcOver,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: (backgroundColor ?? defaultBgColor).withOpacity(0.8),
                borderRadius: borderRadius ?? BorderRadius.circular(24),
                border: Border.all(
                  color: theme.brightness == Brightness.light
                      ? Colors.white.withOpacity(0.2)
                      : Colors.black.withOpacity(0.2),
                ),
              ),
              child: Container(
                height: height + MediaQuery.of(context).padding.bottom,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom,
                  top: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(items.length, (index) {
                    final item = items[index];
                    return Expanded(
                      child: Obx(() {
                        final isSelected =
                            controller.selectedIndex.value == index;
                        return _buildNavItem(
                          context,
                          item,
                          index,
                          isSelected,
                        );
                      }),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    NavItem item,
    int index,
    bool isSelected,
  ) {
    final theme = Theme.of(context);
    final itemColor = isSelected
        ? (selectedItemColor ?? item.activeColor ?? theme.colorScheme.primary)
        : (unselectedItemColor ??
            item.inactiveColor ??
            theme.textTheme.bodyLarge?.color?.withOpacity(0.6) ??
            Colors.grey);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => controller.changeIndex(index),
      child: Container(
        constraints: BoxConstraints(
          minHeight: height - 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: animationDuration,
              curve: animationCurve,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? itemColor.withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(
                      begin: 0.0,
                      end: isSelected ? 1.0 : 0.0,
                    ),
                    curve: Curves.easeOutBack,
                    duration: animationDuration,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, -4 * value),
                        child: Transform.scale(
                          scale: 1.0 + (0.2 * value),
                          child: Icon(
                            item.icon,
                            color: Color.lerp(
                              itemColor.withOpacity(0.6),
                              itemColor,
                              value,
                            ),
                            size: iconSize,
                          ),
                        ),
                      );
                    },
                  ),
                  if (item.showBadge)
                    Obx(() {
                      final badgeCount = controller.getBadgeCount(index);
                      if (badgeCount > 0) {
                        return Positioned(
                          right: -8,
                          top: -4,
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.elasticOut,
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.error,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme.colorScheme.error
                                            .withOpacity(0.3),
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 18,
                                    minHeight: 18,
                                  ),
                                  child: Text(
                                    badgeCount.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                ],
              ),
            ),
            if ((showLabels && showUnselectedLabels) ||
                (showLabels && showSelectedLabels && isSelected))
              AnimatedSlide(
                duration: animationDuration,
                curve: animationCurve,
                offset: Offset(0, isSelected ? 0 : 0.2),
                child: AnimatedOpacity(
                  duration: animationDuration,
                  curve: animationCurve,
                  opacity: isSelected ? 1 : 0.7,
                  child: Container(
                    margin: const EdgeInsets.only(top: 4),
                    child: Text(
                      item.label,
                      style: TextStyle(
                        color: itemColor,
                        fontSize:
                            isSelected ? selectedFontSize : unselectedFontSize,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
