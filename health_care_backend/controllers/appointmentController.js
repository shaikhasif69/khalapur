let Appointment = require("../models/Appointment");
exports.addAppointment = async (req, res) => {
    try {
        const data = req.body;
        let appointment = new Appointment(data);
        let response = await appointment.addAppointment();
        res.status(200).json(response)
    } catch (e) {
        console.log(e);
        return res.status(500).json({ message: "Internal Server Error", error: e });
    }
}

exports.getAllAppointments = async (req, res) => {
    try {
        let appointment = new Appointment()
        let response = await appointment.getAllAppointments()
        res.status(200).json(response)
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
}

exports.getAppointmentById = async (req, res) => {
    try {
        let appointment = new Appointment()
        let response = await appointment.getAppointmentById(req.params.appointmentId)
        res.status(200).json(response)
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error", error: error });
    }
}

exports.getAppointmentsByStatus = async (req, res) => {
    try {
        let appointment = new Appointment()
        let response = await appointment.getAppointmentsByStatus(req.params.status)
        res.status(200).json(response)
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error", error: error });
    }
}


exports.getAppointmentsByDoctorId = async (req, res) => {
    try {
        let appointment = new Appointment()
        let response = await appointment.getAppointmentsByDoctorId(req.params.doctorId)
        res.status(200).json(response)
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error", error: error });
    }
}
exports.getAppointmentsByPatientId = async (req, res) => {
    try {
        let appointment = new Appointment()
        let response = await appointment.getAppointmentsByPatientId(req.params.patientId)
        res.status(200).json(response)
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error", error: error });
    }
}

exports.closeAppointment = async (req, res) => {
    try {
        let appointment = new Appointment()
        let response = await appointment.closeAppointment(req.body.appointmentId)
        res.status(200).json(response.value)
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error", error: error });
    }
}