let Patient = require("../models/Patient");

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