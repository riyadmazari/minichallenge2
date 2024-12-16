import 'package:flutter/material.dart';

class ServicesSubscriptions extends StatelessWidget {
  final List<String> subscribedServices;
  final ValueChanged<List<String>> onUpdate;

  const ServicesSubscriptions({
    Key? key,
    required this.subscribedServices,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example services
    final allServices = ['Netflix', 'HBO Max', 'Disney+', 'Amazon Prime'];
    final selected = Set<String>.from(subscribedServices);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Subscribed Services', style: Theme.of(context).textTheme.titleMedium),
        Wrap(
          spacing: 8,
          children: allServices.map((service) {
            final isSelected = selected.contains(service);
            return ChoiceChip(
              label: Text(service),
              selected: isSelected,
              onSelected: (val) {
                if (val) {
                  selected.add(service);
                } else {
                  selected.remove(service);
                }
                onUpdate(selected.toList());
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
