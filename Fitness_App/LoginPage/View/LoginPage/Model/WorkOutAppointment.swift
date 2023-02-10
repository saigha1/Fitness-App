//
//  WorkOutAppointment.swift
//  Fitness_App
//
//  Created by Xavier on 2/9/23.
//

import Foundation

struct WorkOutAppointment {
    var appointmentID: UUID
    var userID: UUID
    var trainerID: UUID
    var date: Date
    var isCompleted: Bool
}


//TODO: Replace with data from JSON
let appointments: [WorkOutAppointment] = [
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: Date(),
        isCompleted: false),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20230120".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20230114".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20230111".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20230107".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20230103".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20221222".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20221221".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20221220".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20221202".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20221122".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20221120".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20221020".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20220918".yyyyMMddToDate(),
        isCompleted: true),
    WorkOutAppointment(
        appointmentID: UUID(),
        userID: userIDMichaelLogan,
        trainerID: UUID(),
        date: "20220917".yyyyMMddToDate(),
        isCompleted: true)
]
