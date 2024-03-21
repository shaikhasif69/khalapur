const patientsCollection = require("../db").db().collection("patients");
const ObjectID = require("mongodb").ObjectID;
const bcrypt = require("bcrypt");

let Patient = function (data) {
    this.data = data;
    this.errors = [];
};

Patient.prototype.cleanUp = function () {
    this.data = {
        patientName: this.data.patientName,
        patientEmail: this.data.patientEmail,
        patientMobileNo: this.data.patientMobileNo,
        patientPassword: this.data.patientPassword,
        weight: this.data.weight,
        disability: this.data.disability,
        geneticDisorder: this.data.geneticDisorder,
        bloodGroup: this.data.bloodGroup,
        otherDisease: this.data.otherDisease,

        createdDate: new Date(),
    };
};

Patient.prototype.addPatient = async function () {
    this.cleanUp();
    let salt = bcrypt.genSaltSync(10);
    this.data.patientPassword = bcrypt.hashSync(
        this.data.patientPassword,
        salt
    );
    let data = await patientsCollection.insertOne(this.data);
    let patient = await patientsCollection.findOne({ _id: new ObjectID(data.insertedId) });
    return {
        message: "ok",
        data: patient,
    };
};

// Patient.prototype.getDoctorById = async function (doctorId) {
//     let doctor = await doctorsCollection.findOne({ _id: new ObjectID(doctorId) });
//     return doctor;
// }


Patient.prototype.getAllPatients = async function () {
    let data = await patientsCollection.find().toArray();
    return data;
}
module.exports = Patient;
