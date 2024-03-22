let Doctor = require("../models/Doctor");
let Appointment = require("../models/Appointment");
let Patient = require("../models/Patient");
let QRCode = require('qrcode');
let fs = require('fs');
let path = require('path');
const app = require("../app");
exports.addDoctor = async (req, res) => {
    try {
        const data = req.body;
        let doctor = new Doctor(data);
        let response = await doctor.addDoctor();
        res.status(200).json(response)
    } catch (e) {
        console.log(e);
        return res.status(500).json({ response });
    }
};

exports.getAllDoctors = async (req, res) => {
    try {
        let doctor = new Doctor()
        let response = await doctor.getAllDoctors()
        res.status(200).json(response)
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
}
exports.getDoctorById = async (req, res) => {
    try {
        let doctorId = req.params.doctorId
        console.log(doctorId);
        let doctor = new Doctor()
        let response = await doctor.getDoctorById(doctorId)
        res.status(200).json(response)
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
}

exports.displayDashboard = async (req, res) => {
    try {
        let appointment = new Appointment()
        let pendingAppointments = await appointment.getAppointmentsByStatus("pending")
        let completedAppointments = await appointment.getAppointmentsByStatus("completed")
        let totalNoOfAppointments = (await appointment.getAllAppointments()).length
        let totalNoOfPendingAppointments = (await appointment.getAppointmentsByStatus("pending")).length
        let totalNoOfCompletedAppointments = (await appointment.getAppointmentsByStatus("completed")).length
        res.render("dashboard.ejs", { pendingAppointments, completedAppointments, totalNoOfAppointments, totalNoOfPendingAppointments, totalNoOfCompletedAppointments })
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
}

exports.displayAppointmentsPage = async (req, res) => {
    try {
        let appointment = new Appointment()
        let pendingAppointments = await appointment.getAppointmentByDoctorIdAndStatus("65fc0d33be198703be808c5a", "pending")

        res.render("./Appointment/appointment-list", { pendingAppointments })
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
}

exports.displayReportGenPage = async (req, res) => {
    let appointmentId = req.params.appointmentId;
    let doctorId = req.params.doctorId;
    let patientId = req.params.patientId;

    // var file_path = "";
    // QRCode.toDataURL(appointmentId, function (err, src) {
    //     if (err) {
    //         console.log(err);
    //         return res.send(err); // Return error response
    //     }
    //     file_path = "./qrcodes/" + Date.now() + ".png";
    //     QRCode.toFile(file_path, appointmentId, {
    //         color: {
    //             dark: '#000',  // Black dots
    //             light: '#0000' // Transparent background
    //         }
    //     }, function (err) {
    //         if (err) {
    //             console.log(err);
    //             return res.send(err); // Return error response
    //         }
    // Render the page after the file has been created
    res.render("./Appointment/report-gen.ejs", {
        // qrcode: "http://localhost:4000/qrcodes/" + file_path.split('/').pop(), // Use the correct file path
        appointmentId,
        doctorId,
        patientId,
        // img_src: file_path
    });


}