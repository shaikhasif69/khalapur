let Doctor = require("../models/Doctor");

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