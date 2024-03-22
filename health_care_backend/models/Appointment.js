const appointmentsCollection = require("../db").db().collection("appointments");
const ObjectID = require("mongodb").ObjectID;
const bcrypt = require("bcrypt");
const app = require("../app");

let Appointment = function (data) {
    this.data = data;
    this.errors = [];
};

Appointment.prototype.cleanUp = function () {
    this.data = {
        doctorId: new ObjectID(this.data.doctorId),
        patientId: new ObjectID(this.data.patientId),
        appointmentDate: this.data.appointmentDate,
        appointmentStartTime: this.data.appointmentStartTime,
        appointmentEndTime: this.data.appointmentEndTime,
        appointmentStatus: "pending",//rejected //completed
        createdDate: new Date(),
    };
};

Appointment.prototype.addAppointment = async function () {
    this.cleanUp();
    let data = await appointmentsCollection.insertOne(this.data);
    let appointment = await appointmentsCollection.findOne({ _id: new ObjectID(data.insertedId) });
    return {
        message: "ok",
        data: appointment,
    };
}

Appointment.prototype.getAllAppointments = async function () {
    let data = await appointmentsCollection.find().toArray();
    return data;
}
Appointment.prototype.getAppointmentById = async function (appointmentId) {
    let data = await appointmentsCollection.findOne({ _id: new ObjectID(appointmentId) });
    return data;
}
Appointment.prototype.getAppointmentsByStatus = async function (appointmentStatus) {
    console.log(appointmentStatus);
    let data = await appointmentsCollection.find({ appointmentStatus: appointmentStatus }).toArray();
    return data;
}
Appointment.prototype.getAppointmentsByDoctorId = async function (doctorId) {
    let data = await appointmentsCollection.find({ doctorId: new ObjectID(doctorId) }).toArray();
    return data;

}
Appointment.prototype.getAppointmentByDoctorIdAndStatus = async function (doctorId, appointmentStatus) {
    let data = await appointmentsCollection.find({ doctorId: new ObjectID(doctorId), appointmentStatus: appointmentStatus }).toArray();
    return data;

}
Appointment.prototype.getAppointmentsByPatientId = async function (patientId) {
    let data = await appointmentsCollection.find({ patientId: new ObjectID(patientId) }).toArray();
    return data;
}
Appointment.prototype.closeAppointment = async function (appointmentId) {
    let data = await appointmentsCollection.findOneAndUpdate({ _id: new ObjectID(appointmentId) }, { $set: { appointmentStatus: "completed" } });
    let doc = await appointmentsCollection.findOne({ _id: new ObjectID(appointmentId) });
    console.log(doc);
    return data;
}

module.exports = Appointment;