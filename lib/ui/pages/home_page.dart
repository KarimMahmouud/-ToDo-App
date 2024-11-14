import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do/db/db_helper.dart';
import '../../models/task.dart';
// import '../../services/notification_services.dart';
import '../../ui/pages/add_task_page.dart';
import '../../ui/widgets/button.dart';
import '../../ui/widgets/task_tile.dart';
import '../../controllers/task_controller.dart';
import '../../services/theme_services.dart';
import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late NotifyHelper notifyHelper;
  @override
  void initState() {
    super.initState();
    taskController.getTasks();
    // notifyHelper = NotifyHelper();
    // notifyHelper.initializeNotification();
  }

  DateTime selectedDate = DateTime.now();
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.dialogBackgroundColor,
        appBar: _appBar(),
        body: Column(
          children: [
            addTaskBar(),
            addDateBar(),
            const SizedBox(height: 5),
            showTask(),
          ],
        ));
  }

  _appBar() {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () => taskController.deleteAllTasks(),
          icon: Icon(
            Icons.cleaning_services_outlined,
            size: 25,
            color: Get.isDarkMode ? white : Colors.black,
          ),
        ),
        const SizedBox(width: 20),
        const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('images/person.jpeg'),
        ),
        const SizedBox(width: 20),
      ],
      centerTitle: true,
      elevation: 0,
      backgroundColor: context.theme.dialogBackgroundColor,
      leading: IconButton(
        onPressed: () {
          ThemeServices().switchTheme();
        },
        icon: Icon(
          Get.isDarkMode
              ? Icons.wb_sunny_outlined
              : Icons.nightlight_round_outlined,
          size: 25,
          color: Get.isDarkMode ? white : Colors.black,
        ),
      ),
    );
  }

  addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? white : Colors.black,
                ),
              ),
              Text(
                'Today',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? white : Colors.black,
                ),
              ),
            ],
          ),
          MyButton(
              lable: '+ Add Task',
              onTap: () async {
                await Get.to(const AddTaskPage());
                taskController.getTasks();
              })
        ],
      ),
    );
  }

  addDateBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 5),
      child: DatePicker(
        dateTextStyle: TextStyle(
          color: Get.isDarkMode ? white : Colors.black,
        ),
        dayTextStyle: TextStyle(
          color: Get.isDarkMode ? white : Colors.black,
        ),
        monthTextStyle: TextStyle(
          color: Get.isDarkMode ? white : Colors.black,
        ),
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        width: 70,
        height: 100,
        selectedTextColor: white,
        selectionColor: Get.isDarkMode
            ? const Color.fromARGB(255, 124, 46, 46)
            : primaryClr,
        onDateChange: (newDate) {
          setState(() => selectedDate = newDate);
        },
      ),
    );
  }

  showTask() {
    return Expanded(
      child: Obx(() {
        if (taskController.taskList.isEmpty) {
          return noTaskMessage();
        } else {
          return RefreshIndicator(
            onRefresh: () async => taskController.getTasks(),
            child: ListView.builder(
              scrollDirection:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? Axis.horizontal
                      : Axis.vertical,
              itemCount: taskController.taskList.length,
              itemBuilder: (context, index) {
                var task = taskController.taskList[index];

                // var date = DateFormat.jm().parse(task.startTime!);

                // var myTime = DateFormat('HH:mm').format(date);

                // notifyHelper.scheduledNotification(
                //   int.parse(myTime.toString().split(':')[0]),
                //   int.parse(myTime.toString().split(':')[1]),
                //   task,
                // );

                if ((task.repeat == 'Daily' || task.repeat == 'None') ||
                    task.date == DateFormat.yMd().format(selectedDate) ||
                    (task.repeat == 'Weekly' &&
                        selectedDate
                                    .difference(
                                        DateFormat.yMd().parse(task.date!))
                                    .inDays %
                                7 ==
                            0) ||
                    (task.repeat == 'Monthly' &&
                        DateFormat.yMd().parse(task.date!).day ==
                            selectedDate.day)) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(seconds: 2),
                    child: SlideAnimation(
                      horizontalOffset: 300,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () => showButtomSheet(context, task),
                          child: TaskTile(task),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          );
        }
      }),
    );
  }

  noTaskMessage() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(seconds: 2),
          child: RefreshIndicator(
            onRefresh: () async => taskController.getTasks(),
            child: SingleChildScrollView(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                direction:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? Axis.horizontal
                        : Axis.vertical,
                children: [
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? const SizedBox(height: 5)
                      : const SizedBox(height: 220),
                  SvgPicture.asset(
                    'images/task.svg',
                    height: 100,
                    // ignore: deprecated_member_use
                    color: primaryClr.withOpacity(.5),
                    semanticsLabel: 'Task',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    child: Text(
                      'You dont have any any task yet ! \n Add new task to make your days productive.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? white : Colors.black,
                      ),
                    ),
                  ),
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? const SizedBox(height: 120)
                      : const SizedBox(height: 180),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildButtomSheet({
    required String lable,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 65,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(30),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            lable,
            style: isClose
                ? TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? white : Colors.black,
                  )
                : const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
          ),
        ),
      ),
    );
  }

  showButtomSheet(BuildContext context, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).orientation == Orientation.landscape
            ? task.isCompleted == 1
                ? MediaQuery.of(context).size.height * 0.6
                : MediaQuery.of(context).size.height * 0.5
            : task.isCompleted == 1
                ? MediaQuery.of(context).size.height * 0.26
                : MediaQuery.of(context).size.height * 0.35,
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(
          children: [
            Flexible(
              child: Container(
                height: 5,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                ),
              ),
            ),
            const SizedBox(height: 20),
            task.isCompleted == 1
                ? Container()
                : buildButtomSheet(
                    lable: 'Task Completed',
                    clr: primaryClr,
                    onTap: () {
                      taskController.updateTasks(task.id!);
                      Get.back();
                      taskController.getTasks();
                    },
                  ),
            buildButtomSheet(
              lable: 'Delete Completed',
              clr: Colors.red[400]!,
              onTap: () {
                DBHelper.delete(task);
                Get.back();
                taskController.getTasks();
              },
            ),
            Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
            buildButtomSheet(
              lable: 'Cancle',
              clr: primaryClr,
              onTap: () {
                Get.back();
                taskController.getTasks();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ));
  }
}
