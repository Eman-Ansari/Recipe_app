import 'package:flutter/material.dart';

class CardModel {
  final String name;
  final IconData icon;
  final bool active;
  CardModel({required this.name, required this.icon, required this.active});
}

List CardData = [
  CardModel(name: "Flight", icon: Icons.flight, active: true),
  CardModel(name: "Hotel", icon: Icons.hotel, active: true),
  CardModel(name: "Hotel", icon: Icons.location_on, active: true),
  CardModel(name: "Food", icon: Icons.food_bank_rounded, active: true),
  CardModel(name: "Flight", icon: Icons.flight, active: true),
  CardModel(name: "Flight", icon: Icons.flight, active: true),
  CardModel(name: "Flight", icon: Icons.flight, active: true),
];
