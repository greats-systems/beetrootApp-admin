import 'package:core_erp/models/business.dart';
import 'package:core_erp/models/order.dart';
import 'package:core_erp/models/person.dart';

class EmployeeJobs {
  String? userID;
  String? createdDate;
  String? updatedDate;
  String? deletedDate;
  Person? employee;
  Person? supervisor;
  String? taskName;
  String? timeTaken;
  String? department;
  String? hourlyRate;
  Business? business;
  List<Order>? performedAssignments;

  EmployeeJobs({
    this.userID,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.employee,
    this.supervisor,
    this.taskName,
    this.timeTaken,
    this.department,
    this.hourlyRate,
    this.business,
    this.performedAssignments,
  });

  factory EmployeeJobs.fromJson(Map<String, dynamic> json) {
    return EmployeeJobs(
      userID: json['userID'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      deletedDate: json['deletedDate'],
      employee: Person.fromJson(json['employee']),
      supervisor: Person.fromJson(json['supervisor']),
      taskName: json['taskName'],
      timeTaken: json['timeTaken'],
      department: json['department'],
      hourlyRate: json['hourlyRate'],
      business: Business.fromJson(json['business']),
      performedAssignments: (json['performedAssignments'] as List<dynamic>)
          .map((assignment) => Order.fromJson(assignment))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'deletedDate': deletedDate,
      'employee': employee!.toJson(),
      'supervisor': supervisor!.toJson(),
      'taskName': taskName,
      'timeTaken': timeTaken,
      'department': department,
      'hourlyRate': hourlyRate,
      'business': business!.toJson(),
      'performedAssignments': performedAssignments!
          .map((assignment) => assignment.toJson())
          .toList(),
    };
  }
}
