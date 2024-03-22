let Patient = require("../models/Patient");
let Session = require("../models/Session");
let Doctor = require("../models/Doctor");
exports.addPatient = async (req, res) => {
    try {
        const data = req.body;
        let patient = new Patient(data);
        let response = await patient.addPatient();
        res.status(200).json(response)
    } catch (e) {
        console.log(e);
        return res.status(500).json({ message: "Internal Server Error", error: e });
    }
};

exports.getAllPatients = async (req, res) => {
    try {
        let patient = new Patient()
        let response = await patient.getAllPatients()
        res.status(200).json(response)
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
}

exports.login = async (req, res) => {
    try {
        const { patientEmail, patientPassword } = req.body;
        console.log(patientEmail, patientPassword);
        let patient = new Patient();
        let response = await patient.login(patientEmail, patientPassword);

        if (response == "Invalid Credentials") {
            return res.status(200).json({ result: response });
        }




        return res.status(200).json(response);

    } catch (e) {
        console.log(e);
        return res.status(500).json({ message: "Internal Sever Error" });
    }
};

exports.getHealthRecords = async (req, res) => {
    try {
        let session = new Session()
        let doctor = new Doctor()
        let response = await session.getAllSessionOfParticularPatient(req.params.patientId)
        let doctorDetails = await doctor.getDoctorById(response[0].doctorId)
        res.status(200).json(response)
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
}
// exports.getDoctorById = async (req, res) => {
//     try {
//         let doctorId = req.params.doctorId
//         console.log(doctorId);
//         let doctor = new Doctor()
//         let response = await doctor.getDoctorById(doctorId)
//         res.status(200).json(response)
//     } catch (error) {
//         console.log(error);
//         res.status(500).json({ message: "Internal Server Error" });
//     }
// }