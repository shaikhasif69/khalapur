let Doctor = require("../models/Doctor");
let Appointment = require("../models/Appointment");
let Patient = require("../models/Patient");

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
        let totalNoOfAppointments = (await appointment.getAllAppointments()).length
        let totalNoOfPendingAppointments = (await appointment.getAppointmentsByStatus("pending")).length
        let totalNoOfCompletedAppointments = (await appointment.getAppointmentsByStatus("completed")).length
        res.render("dashboard.ejs", { pendingAppointments, totalNoOfAppointments, totalNoOfPendingAppointments, totalNoOfCompletedAppointments })
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
}

exports.addAppointmentPage = async (req, res) => {
    try {
        res.render("add-appointment")
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
}