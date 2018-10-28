import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../util/url.dart';
import '../querry_model.dart';

class SpacexCompanyModel extends QuerryModel {
  Company _company;

  @override
  Future loadData() async {
    final companyResponse = await http.get(Url.spacexCompany);
    response = await http.get(Url.spacexAchievements);
    clearLists();

    snapshot = json.decode(response.body);
    items.addAll(snapshot
        .map((achievement) => Achievement.fromJson(achievement))
        .toList());

    _company = Company.fromJson(json.decode(companyResponse.body));

    images.addAll(Url.spacexCompanyScreen);

    loadingState(false);
  }

  Company get company => _company;
}

class Company {
  final String fullName, name, founder, ceo, cto, coo, city, state, details;
  final List<String> links;
  final num founded, employees, valuation;

  Company({
    this.fullName,
    this.name,
    this.founder,
    this.ceo,
    this.cto,
    this.coo,
    this.city,
    this.state,
    this.links,
    this.details,
    this.founded,
    this.employees,
    this.valuation,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      fullName: 'Space Exploration Technologies Corporation',
      name: json['name'],
      founder: json['founder'],
      ceo: json['ceo'],
      cto: json['cto'],
      coo: json['coo'],
      city: json['headquarters']['city'],
      state: json['headquarters']['state'],
      links: [
        json['links']['website'],
        json['links']['twitter'],
        json['links']['flickr'],
      ],
      details: json['summary'],
      founded: json['founded'],
      employees: json['employees'],
      valuation: json['valuation'],
    );
  }

  String get getFounderDate => 'Founded in $founded by $founder';

  String get getValuation =>
      NumberFormat.currency(symbol: '\$', decimalDigits: 0).format(valuation);

  String get getLocation => '$city, $state';

  String get getEmployees => NumberFormat.decimalPattern().format(employees);
}

class Achievement {
  final String name, details, url;
  final DateTime date;

  Achievement({
    this.name,
    this.details,
    this.url,
    this.date,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      name: json['title'],
      details: json['details'],
      url: json['links']['article'],
      date: DateTime.parse(json['event_date_utc']).toLocal(),
    );
  }

  String get getDate => DateFormat.yMMMMd().format(date);
}
