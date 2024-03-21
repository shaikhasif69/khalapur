const doctorsCollection = require("../db").db().collection("doctors");
const ObjectID = require("mongodb").ObjectID;
const bcrypt = require("bcrypt");

let Doctor = function (data) {
    this.data = data;
    this.errors = [];
};

Doctor.prototype.cleanUp = function () {
    this.data = {
        doctorName: this.data.doctorName,
        doctorEmail: this.data.doctorEmail,
        doctorMobileNo: this.data.doctorMobileNo,
        doctorPassword: this.data.doctorPassword,
        doctorQualification: this.data.doctorQualification,
        doctorSpecialization: this.data.doctorSpecialization,

        createdDate: new Date(),
    };
};

Doctor.prototype.addDoctor = async function () {
    this.cleanUp();
    let salt = bcrypt.genSaltSync(10);
    this.data.doctorPassword = bcrypt.hashSync(
        this.data.doctorPassword,
        salt
    );
    let data = await doctorsCollection.insertOne(this.data);
    let doctor = await doctorsCollection.findOne({ _id: new ObjectID(data.insertedId) });
    return {
        message: "ok",
        data: doctor,
    };
};

Doctor.prototype.getDoctorById = async function (doctorId) {
    let doctor = await doctorsCollection.findOne({ _id: new ObjectID(doctorId) });
    return doctor;
}


Doctor.prototype.getAllDoctors = async function () {
    let data = await doctorsCollection.find().toArray();
    return data;
}
module.exports = Doctor;
