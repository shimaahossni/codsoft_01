// features/home/persentation/widget/bottomsheet.dart
import 'package:alarm/core/services/app_local_storage.dart';
import 'package:alarm/core/widget/custom_button.dart';
import 'package:alarm/features/home/data/task_model.dart';
import 'package:alarm/features/home/persentation/views/alarms_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

void showBottomSheetWidget(
  BuildContext context, {
  required DateTime initialTime,
  required ValueChanged<DateTime> onTimeChanged,
  required VoidCallback onSave,
  bool snoozeEnabled = true,
}) {
  final TaskMdel? taskmodel;
  final mediaquery = MediaQuery.of(context).size;
  ValueNotifier<DateTime> selectedTime = ValueNotifier<DateTime>(initialTime);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Wrap(
          children: [
            Column(
              children: [
                // Handle bottom sheet content
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: mediaquery.height * .01),
                  height: mediaquery.height * .01,
                  width: mediaquery.width * .1,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(mediaquery.height * .02),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Time Picker
                      SizedBox(
                        height: 200,
                        child: ValueListenableBuilder<DateTime>(
                          valueListenable: selectedTime,
                          builder: (context, value, _) {
                            return CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.time,
                              initialDateTime: value,
                              use24hFormat: false,
                              onDateTimeChanged: (DateTime newDateTime) {
                                selectedTime.value = newDateTime;
                                onTimeChanged(newDateTime);
                                print(newDateTime);
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Label Selection
                      ListTile(
                        leading: const Icon(Icons.label),
                        title: const Text('Label'),
                        trailing: ValueListenableBuilder<Box<dynamic>>(
                          valueListenable: AppLocalStorage.userBox.listenable(),
                          builder: (context, box, _) {
                            String currentLabel = AppLocalStorage.getCachedData(
                                    AppLocalStorage.label) ??
                                'Alarm'; // Default to 'Alarm' if null
                            return Text(
                              currentLabel,
                              style: const TextStyle(color: Colors.grey),
                            );
                          },
                        ),
                        onTap: () async {
                          // Define available label options
                          List<String> labelOptions = [
                            'Alarm',
                            'Meeting',
                            'Workout',
                            'Reminder',
                          ];

                          // Show a dialog with a dropdown to select a label
                          String? selectedLabel = await showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              // Ensure a default value if AppLocalStorage is null
                              String dropdownValue = AppLocalStorage.cachedData(
                                    AppLocalStorage.label,
                                    'Alarm', // Set a default fallback value if null
                                  ) ??
                                  'Alarm'; // In case it is still null after cachedData

                              return AlertDialog(
                                title: const Text('Select Label'),
                                content: StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return DropdownButton<String>(
                                      value: dropdownValue,
                                      isExpanded: true,
                                      items: labelOptions
                                          .map((label) =>
                                              DropdownMenuItem<String>(
                                                value: label,
                                                child: Text(label),
                                              ))
                                          .toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                        });
                                      },
                                    );
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context), // Cancel action
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Save the selected label in AppLocalStorage
                                      AppLocalStorage.cachedData(
                                          AppLocalStorage.label, dropdownValue);
                                      Navigator.pop(context,
                                          dropdownValue); // Confirm selection
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );

                          // Save the selected label in Hive after the dialog closes
                          if (selectedLabel != null) {
                            var box = Hive.box<String>('user');
                            box.put(AppLocalStorage.label, selectedLabel);
                            print('Label saved: $selectedLabel');
                          }
                        },
                      ),

                      const Divider(height: 1),

                      // Repeat Option
                      ListTile(
                        leading: const Icon(Icons.repeat),
                        title: const Text('Repeat'),
                        trailing: ValueListenableBuilder<Box<dynamic>>(
                          valueListenable: AppLocalStorage.userBox.listenable(),
                          builder: (context, box, _) {
                            // Retrieve the current repeat value or default to "daily"
                            String currentRepeat =
                                AppLocalStorage.getCachedData(
                                        AppLocalStorage.repeat) ??
                                    'daily';
                            return Text(
                              currentRepeat,
                              style: const TextStyle(color: Colors.grey),
                            );
                          },
                        ),
                        onTap: () async {
                          // Define repeat options
                          List<String> repeatOptions = [
                            'daily',
                            'weekly',
                            'monthly',
                            'yearly'
                          ];

                          // Show a dialog with a dropdown to select a repeat option
                          String? selectedRepeat = await showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              // Retrieve the current repeat value from AppLocalStorage or default to 'daily'
                              String dropdownValue =
                                  AppLocalStorage.getCachedData(
                                          AppLocalStorage.repeat) ??
                                      'daily';

                              return AlertDialog(
                                title: const Text('Select repeat'),
                                content: StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return DropdownButton<String>(
                                      value: dropdownValue,
                                      isExpanded: true,
                                      items: repeatOptions
                                          .map((repeat) =>
                                              DropdownMenuItem<String>(
                                                value: repeat,
                                                child: Text(repeat),
                                              ))
                                          .toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                        });
                                      },
                                    );
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context), // Cancel action
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Handle repeat selection
                                      AppLocalStorage.cachedData(
                                          AppLocalStorage.repeat,
                                          dropdownValue);
                                      Navigator.pop(context,
                                          dropdownValue); // Confirm selection
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );

                          // Save the selected repeat value in Hive after the dialog closes
                          if (selectedRepeat != null) {
                            var box = Hive.box<String>('user');
                            box.put(AppLocalStorage.repeat, selectedRepeat);
                            print('Repeat saved: $selectedRepeat');
                          }
                        },
                      ),

                      const Divider(height: 1),

                      // Sound Option
                      ListTile(
                        leading: const Icon(Icons.volume_up),
                        title: const Text('Sound'),
                        trailing: ValueListenableBuilder<Box<dynamic>>(
                          valueListenable: AppLocalStorage.userBox.listenable(),
                          builder: (context, box, _) {
                            // Retrieve the current sound value or default to "sound1"
                            String currentSound = AppLocalStorage.getCachedData(
                                    AppLocalStorage.sound) ??
                                'sound1';
                            return Text(
                              currentSound,
                              style: const TextStyle(color: Colors.grey),
                            );
                          },
                        ),
                        onTap: () async {
                          // Define sound options
                          List<String> soundOptions = [
                            'sound1',
                            'sound2',
                            'sound3',
                            'sound4',
                          ];

                          // Show a dialog with a dropdown to select a sound
                          String? selectedSound = await showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              // Retrieve the current sound from Hive or default to 'sound1'
                              String dropdownValue =
                                  AppLocalStorage.getCachedData(
                                          AppLocalStorage.sound) ??
                                      'sound1';

                              return AlertDialog(
                                title: const Text('Select Sound'),
                                content: StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return DropdownButton<String>(
                                      value: dropdownValue,
                                      isExpanded: true,
                                      items: soundOptions
                                          .map((sound) =>
                                              DropdownMenuItem<String>(
                                                value: sound,
                                                child: Text(sound),
                                              ))
                                          .toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                        });
                                      },
                                    );
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context), // Cancel action
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Handle sound selection and save it
                                      AppLocalStorage.cachedData(
                                          AppLocalStorage.sound, dropdownValue);
                                      Navigator.pop(context,
                                          dropdownValue); // Confirm selection
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );

                          // Save the selected sound in Hive after the dialog closes
                          if (selectedSound != null) {
                            var box = Hive.box<String>('user');
                            box.put(AppLocalStorage.sound, selectedSound);
                            print('Sound saved: $selectedSound');
                          }
                        },
                      ),

                      const Divider(height: 1),

                      // Snooze Option
                      ListTile(
                        leading: const Icon(Icons.snooze),
                        title: const Text('Snooze'),
                        trailing: StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Switch(
                              value: snoozeEnabled,
                              onChanged: (bool value) {
                                setState(() {
                                  snoozeEnabled =
                                      value; // Update the switch state
                                });
                                // Store the value in AppLocalStorage as a string

                                AppLocalStorage.cachedData(
                                    AppLocalStorage.isSnooze.toString(),
                                    value.toString());
                              },
                            );
                          },
                        ),
                      ),

                      Gap(mediaquery.height * .02),

                      // Save Button
                      CustomButton(
                        text: 'Save',
                        width: mediaquery.width * .35,
                        onPressed: () {
                          // Generate a unique task ID
                          String id = DateTime.now().toIso8601String();

                          // Format the date
                          String formattedDate = DateFormat('dd/MM/yyyy')
                              .format(selectedTime.value);

                          // Create a new TaskMdel object
                          TaskMdel newTask = TaskMdel(
                            id: id,
                            title: AppLocalStorage.getCachedData(
                                AppLocalStorage.label),
                            note: AppLocalStorage.getCachedData(
                                AppLocalStorage.repeat),
                            date: formattedDate,
                            startTime:
                                DateFormat('HH:mm').format(selectedTime.value),
                            endTime:
                                DateFormat('HH:mm').format(selectedTime.value),
                            color: 1,
                            isCompleted: false,
                          );

                          // Save the task in the Hive box
                          AppLocalStorage.cachedTaskData(id, newTask);

                          // Log the saved task for debugging
                          print('Task Saved: $newTask');

                          // Close the bottom sheet and navigate to the next screen
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AlarmsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
