import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/theme.dart';
import 'package:to_do/ui/widgets/button.dart';
import 'package:to_do/ui/widgets/input_field.dart';

import '../../controllers/task_controller.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController taskController = Get.put(TaskController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  String startTime = '00:00';
  String endTime = '00:00';

  int selctedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  String selectedRepeat = 'None';
  List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];

  int selctedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.dialogBackgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                'Add Task',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? white : Colors.black),
              ),
              InputField(
                title: 'Title',
                hint: 'Enter title here',
                controller: titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter note here',
                controller: noteController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(selectedDate),
                widget: IconButton(
                  onPressed: () {
                    getDateFromUser();
                  },
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: startTime,
                      widget: IconButton(
                        onPressed: () {
                          getTimeFromUser(isStartTime: false);
                        },
                        icon: const Icon(
                          Icons.access_time,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: endTime,
                      widget: IconButton(
                        onPressed: () {
                          getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(
                          Icons.access_time,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                title: 'Remind',
                hint: '$selctedRemind minutes early',
                widget: Row(
                  children: [
                    DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      dropdownColor: Colors.blueGrey,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                        size: 30,
                      ),
                      elevation: 4,
                      underline: Container(height: 0),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? white : Colors.black,
                      ),
                      items: remindList
                          .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(
                                "$value",
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() => selctedRemind = int.parse(newValue!));
                      },
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
             
              InputField(
                title: 'Repeat',
                hint: selectedRepeat,
                widget: Row(
                  children: [
                    DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      dropdownColor: Colors.blueGrey,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                        size: 30,
                      ),
                      elevation: 4,
                      underline: Container(height: 0),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? white : Colors.black,
                      ),
                      items: repeatList
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (newValue) {
                        setState(() => selectedRepeat = newValue!);
                      },
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  colorPal(),
                  MyButton(
                    lable: "Creat Task",
                    onTap: () {
                      validateData();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      actions: const [
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage("images/person.jpeg"),
        ),
        SizedBox(width: 20),
      ],
      centerTitle: true,
      elevation: 0,
      backgroundColor: context.theme.dialogBackgroundColor,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back,
          size: 25,
          color: primaryClr,
        ),
      ),
    );
  }

  colorPal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: TextStyle(
            color: Get.isDarkMode ? white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          children: List.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                setState(() => selctedColor = index);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : orangeClr,
                  child: selctedColor == index
                      ? const Icon(
                          Icons.done,
                          size: 20,
                          color: white,
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
        // Container(
        //   width: 10,
        //   height: 10,
        //   decoration: const BoxDecoration(
        //     shape: BoxShape.circle,
        //     color: Colors.amber,
        //   ),
        // ),
      ],
    );
  }

  addTasksToDb() async {
    try {
      int val = await taskController.addTask(
        task: Task(
          title: titleController.text,
          note: noteController.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(selectedDate),
          startTime: startTime,
          endTime: endTime,
          color: selctedColor,
          remind: selctedRemind,
          repeat: selectedRepeat,
        ),
      );
      // ignore: avoid_print
      print(val);
    } catch (e) {
      // ignore: avoid_print
      print('error');
    }
  }

  validateData() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      addTasksToDb();
      Get.back();
    } else if (titleController.text.isEmpty && noteController.text.isEmpty) {
      Get.snackbar(
        ' Required',
        'All fieldd are required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.red,
        icon: const Icon(
          Icons.warning_amber_outlined,
          color: Colors.red,
        ),
      );
    } else {
      debugPrint('Something Bad happened');
    }
  }

  getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() => selectedDate = pickedDate);
    } else {
      debugPrint('/');
    }
  }

  getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()));

    // ignore: use_build_context_synchronously
    String formattedTime = pickedTime!.format(context);

    if (!isStartTime) {
      setState(() => startTime = formattedTime);
    } else if (isStartTime) {
      setState(() => endTime = formattedTime);
    } else {
      debugPrint('time cancled or someting is wrong');
    }
  }
}
