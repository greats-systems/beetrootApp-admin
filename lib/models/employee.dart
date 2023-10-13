import 'package:core_erp/models/business.dart';
import 'package:core_erp/models/employee_jobs.dart';
import 'package:core_erp/models/person.dart';

class Employee {
  String? employeeID;
  String? createdDate;
  String? updatedDate;
  String? deletedDate;
  Person? employer;
  Person? profile;
  String? role;
  String? specialization;
  bool? onlineStatus;
  String? department;
  String? salary;
  String? deploymentStatus;
  String? jobRole;
  Business? business;
  List<EmployeeJobs>? performedAssignments;

  Employee({
    this.employeeID,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.employer,
    this.profile,
    this.role,
    this.specialization,
    this.onlineStatus,
    this.department,
    this.salary,
    this.deploymentStatus,
    this.jobRole,
    this.business,
    this.performedAssignments,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeID: json['employeeID'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      deletedDate: json['deletedDate'],
      employer:
          json['employer'] != null ? Person.fromJson(json['employer']) : null,
      profile:
          json['profile'] != null ? Person.fromJson(json['profile']) : null,
      role: json['role'],
      specialization: json['specialization'],
      onlineStatus: json['onlineStatus'],
      department: json['department'],
      salary: json['salary'],
      deploymentStatus: json['deploymentStatus'],
      jobRole: json['jobRole'],
      business:
          json['business'] != null ? Business.fromJson(json['business']) : null,
      performedAssignments: json['performedAssignments'] != null
          ? (json['performedAssignments'] as List<dynamic>)
              .map((assignment) => EmployeeJobs.fromJson(assignment))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeID': employeeID,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'deletedDate': deletedDate,
      'employer': employer!.toJson(),
      'profile': profile!.toJson(),
      'role': role,
      'specialization': specialization,
      'onlineStatus': onlineStatus,
      'department': department,
      'salary': salary,
      'deploymentStatus': deploymentStatus,
      'jobRole': jobRole,
      'business': business!.toJson(),
      'performedAssignments': performedAssignments!
          .map((assignment) => assignment.toJson())
          .toList(),
    };
  }
}
