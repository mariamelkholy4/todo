
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/home/task_list/task_list_item.dart';
import 'package:todo/provider/auth_user_provider.dart';

import 'package:todo/provider/list_provider.dart';
class TaskListTab extends StatefulWidget {

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthUserProvider>(context);

    if(listProvider.tasksList.isEmpty){
      listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
    }
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: listProvider.selectDate,
          onDateChange: (selectedDate) {
            //selectedDate the new date selected.
            listProvider.changeSelectDate(selectedDate, authProvider.currentUser!.id!);
          },
          activeColor: const Color(0xff5D9CEC),
          dayProps: const EasyDayProps(
            todayHighlightStyle: TodayHighlightStyle.withBackground,
            todayHighlightColor: Color(0x6e5d9cec),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context,index){
              return TaskListItem(task: listProvider.tasksList[index],);
            },
            itemCount: listProvider.tasksList.length,
          ),
        ),
      ],
    );
  }


}