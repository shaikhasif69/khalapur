let Session = require("../models/Session");
let Appointment = require("../models/Appointment");
const fs = require("fs");
const path = require("path");
const axios = require("axios");
exports.addSession = async (req, res) => {
    try {
        let multipleNames = [];
        console.log(req.files);
        if (req.files) {
            if (req.files.reportLinks) {
                console.log(req.files.reportLinks);
                console.log("Filesss milaaaa");
                if (Array.isArray(req.files.reportLinks)) {
                    let files = req.files.reportLinks;
                    // console.log(files);
                    const promises = files.map((file) => {
                        const fileName = new Date().getTime().toString() + "-" + file.name;
                        const savePath = path.join(
                            __dirname,
                            "../public/",
                            "sessionAttachments",
                            fileName
                        );
                        multipleNames.push(fileName);

                        return file.mv(savePath);
                    });
                    await Promise.all(promises);
                    req.body.reportLinks = multipleNames;
                } else if (!Array.isArray(req.files)) {
                    let file = req.files.reportLinks;
                    const fileName = new Date().getTime().toString() + "-" + file.name;
                    const savePath = path.join(
                        __dirname,
                        "../public/",
                        "sessionAttachments",
                        fileName
                    );
                    await file.mv(savePath);
                    req.body.reportLinks = fileName;
                }
            }
        }
        const data = req.body;
        console.log(req.body.reportLinks);
        let session = new Session(data);
        let response = await session.addSession();
        console.log("Send data to ocr");
        let ocrLink = response.data.reportLinks
        let ocrResult = await axios.post(`http://${process.env.DJANGO_SERVER}/ocr/`, {
            pdfLinks: `http://192.168.119.85:4000/sessionAttachments/${ocrLink}`
        });
        console.log(ocrResult.data);

        let result = await session.updateSessionDoc(response.data._id, JSON.parse(ocrResult.data));
        let appointment = new Appointment()
        let d = await appointment.closeAppointment(result.appointmentId);
        this.sendNotifcation()
        console.log(result);
        console.log(d);

        res.status(200).redirect("/doctor/displayAppointmentsPage")
    } catch (e) {
        console.log(e);
        return res.status(500).json({ message: "Internal Server Error", error: e });
    }
};

async function sendOcr(data) {


}
exports.getSessionById = async (req, res) => {
    try {
        let session = new Session()
        let response = await session.getSessionById(req.params.sessionId)
        res.status(200).json(response)
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
}
exports.getAllSessionOfParticularPatient = async (req, res) => {
    try {
        let session = new Session()
        let response = await session.getAllSessionOfParticularPatient(req.params.patientId)
        res.status(200).json(response)
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
}

exports.getLatestSessionOfParticularPatient = async (req, res) => {
    try {
        let session = new Session()
        let response = await session.getLatestSessionOfParticularPatient(req.params.patientId)
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

exports.sendNotifcation = async () => {
    // const { title, body, url, dl } = req.body;
    try {
        headers = {
            'Authorization': `key=${process.env.FIREBASE_API_KEY}`,
            'Content-Type': 'application/json',
        };

        let response = await axios.post('https://fcm.googleapis.com/fcm/send', {
            "to": "fdsIFMCCQe2PrQqf-DHCb9:APA91bG6GnOwylP1B9_xRV1yxE8SJ6T2NHwnX1xGq77x64ImCyQ5LU1TpecNAfm4h41RJu3FN5BcpRPvyBc_AZRJSY1vFO2sKiLEVfCEw3goUpOmaw2auhrYELG5jHPh5JwYyAUCz6yK",
            "notification": {
                "title": `ALERT!!`,
                "body": `Appointment Completed and closed successfully`,
                "mutable_content": true,
                "sound": "Tri-tone",
                "url": "https://i.stack.imgur.com/lXio9.jpg?s=256&g=1"
            },
            "data": { "dl": "/notification-screen" }
        }, { headers })
        console.log(response);
    } catch (e) {
        console.log(e);

    }
};
