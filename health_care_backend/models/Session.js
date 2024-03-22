const sessionCollection = require("../db").db().collection("session");
const ObjectID = require("mongodb").ObjectID;
const bcrypt = require("bcrypt");

let Session = function (data) {
    this.data = data;
    this.errors = [];
};
// Reports generated in one session
Session.prototype.cleanUp = function () {
    this.data = {
        doctorId: new ObjectID(this.data.doctorId),
        patientId: new ObjectID(this.data.patientId),
        appointmentId: new ObjectID(this.data.appointmentId),
        sessionRemark: this.data.sessionRemark,
        reports: this.data.reports,
        reportLinks: this.data.reportLinks,
        revisitAdvice: this.data.revisitAdvice,
        weight: this.data.weight,
        bloodGroup: this.data.bloodGroup,
        mainCause: this.data.mainCause,

        eatingAdvisory: "No advisory",
        exerciseAdvisory: "No advisory",
        createdDate: new Date(),
    };
};

Session.prototype.addSession = async function () {
    this.cleanUp();
    console.log("Finallllllll");
    console.log(this.data);
    let data = await sessionCollection.insertOne(this.data);
    let session = await sessionCollection.findOne({ _id: new ObjectID(data.insertedId) });
    return {
        message: "ok",
        data: session,
    };
};

Session.prototype.getSessionById = async function (sessionId) {
    let session = await sessionCollection.findOne({ _id: new ObjectID(sessionId) });
    return session;
}


// Session.prototype.getAllSessionOfParticularPatient = async function (patientId) {
//     let data = await sessionCollection.find({ patientId: new ObjectID(patientId) }).sort({ createdDate: -1 }).toArray();
//     return data;
// }
// Assuming sessionCollection and doctorCollection are your MongoDB collections
// Assuming you have the MongoDB client initialized and connected to your database

Session.prototype.getAllSessionOfParticularPatient = async function (patientId) {
    try {
        const data = await sessionCollection.aggregate([
            { $match: { patientId: new ObjectID(patientId) } },
            { $sort: { createdDate: -1 } },
            {
                $lookup: {
                    from: 'doctors', // Name of the doctor collection
                    localField: 'doctorId',
                    foreignField: '_id',
                    as: 'doctor'
                }
            },
            { $unwind: '$doctor' }, // Unwind the array produced by the lookup

        ]).toArray();

        return data;
    } catch (error) {
        console.error('Error fetching sessions with doctor names:', error);
        throw error;
    }
}


Session.prototype.getLatestSessionOfParticularPatient = async function (patientId) {
    // Assuming doctorsCollection is your MongoDB collection reference

    let data = await doctorsCollection.find({ patientId: new ObjectID(patientId) })
        .sort({ createdDate: -1 }) // Sort in descending order based on createdDate
        .limit(1) // Limit the result to one document

    return data;
}
Session.prototype.updateSessionDoc = async function (sessionId, ocrResult) {
    let data = await sessionCollection.updateOne({ _id: new ObjectID(sessionId) }, { $set: { reports: ocrResult } });
    let doc = await sessionCollection.findOne({ _id: new ObjectID(sessionId) });
    return doc;
}
module.exports = Session;
