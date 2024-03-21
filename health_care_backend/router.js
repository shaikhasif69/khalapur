const router = require("express").Router();
const doctorsController = require("./controllers/doctorController")
// // ? Authentication module
router.post("/doctor/add-doctor", doctorsController.addDoctor)
router.get("/doctor/get-all-doctors", doctorsController.getAllDoctors)
router.get('/doctor/get-single-doctor/:doctorId', doctorsController.getDoctorById)
// // Create a new account, and segregating based on the roles
// router.post("/account/signUp", accountController.signUp);

// // User can signIn with email and password, no need to take role
// router.post("/account/signIn", accountController.signIn);

// // ? Event Management Module

// // Atharva's API
// router.post("/user/getUserByEmail", userController.getUserByEmail);
// router.post(
//     "/recycler/getRecyclerByEmail",
//     recyclerController.getRecyclerByEmail
// );
// router.post(
//     "/organizer/getOrganizerByEmail",
//     organizerController.getOrganizerByEmail
// );

// // Flutter's API
// router.get("/getAllEvents", eventController.getAllEvents);
// router.post("/getSingleEventById", eventController.getSingleEventById);
// router.get("/getAllUpcomingEvents", eventController.getAllUpcomingEvents);
// router.get("/getAllCompletedEvents", eventController.getAllCompletedEvents);
// router.get("/getAllOngoingEvents", eventController.getAllOngoingEvents);

// // User can register in event, and then the user should be pushed in the registeredParticipants[] array
// router.post("/registerEvent", eventController.registerEvent);
// // Organizer can mark present, based on the eventId and userId.
// router.post("/markPresent", eventController.markPresent);

// // Get Count of user who has registered in the events
// router.post(
//     "/getUserEventRegistrationCountById",
//     eventController.getUserEventRegistrationCountById
// );

// // Get Count of user who is present in the events
// router.post(
//     "/getUserEventParticipationCountById",
//     eventController.getUserEventParticipationCountById
// );

// // Get their registered Events
// router.post(
//     "/getUserRegisteredEvents",
//     eventController.getUserRegisteredEvents
// );

// // Get their completed as well as they were present in the events.
// router.post("/getUserCompletedEvents", eventController.getUserCompletedEvents);

// // To check whether user has already registered or not based on userId. If already, return true and show QR scanner on app
// router.post(
//     "/checkIfAlreadyRegistered",
//     eventController.checkIfAlreadyRegistered
// );

// // Get Ongoing events of the organizer based on the email address.
// router.post(
//     "/getOngoingEventsByEmail",
//     eventController.getOngoingEventsByEmail
// );

// // ? Reporting Module

// //add report for unhygenic place with a attachment
// router.post("/report/addReport", reportController.addReport);
// //get all reports
// router.get("/report/getAllReports", reportController.getAllReports);
// // get single report by id
// router.get("/report/getReportById/:reportId", reportController.getReportById);
// // change report status accordingly to pending(by default), resolved, rejected(if fake report)
// router.post("/report/changeReportStatus", reportController.changeReportStatus);
// // get reports by status (pending, resolved, rejected)
// router.get(
//     "/report/getReportsByStatus/:reportStatus",
//     reportController.getReportsByStatus
// );

// //waste pickup schedule module
// router.post(
//     "/pickup/addWastePickupSchedule",
//     wastePickupScheduleController.addWastePickupSchedule
// );

// // ---------Routes for govt. authority-----------

// //          ---- Backend routes -----

// // login route
// router.post("/login", authorityController.login);
// router.get("/logout", authorityController.logout);
// // -- Bio Waste Resources --
// // add bio resource
// router.post("/biowaste/addResources", biowasteController.addResources);
// router.get("/biowaste/getResources", biowasteController.getBiowasteResources);

// // Event's Routes
// router.post("/addEvent", eventController.addEvent);
// router.post("/deleteEventById/:eventId", eventController.deleteEventById);
// router.get("/getEvents", eventController.getEvents);
// router.get("/getEventById/:eventId", eventController.getEventById);
// router.get("/getUpcomingEvents", eventController.getUpcomingEvents);
// router.get("/getCompletedEvents", eventController.getCompletedEvents);
// router.get("/getOngoingEvents", eventController.getOngoingEvents);
// router.get("/getTotalEventsCount", eventController.getTotalEventsCount);
// router.get(
//     "/getAllUpcomingEventsCount",
//     eventController.getAllUpcomingEventsCount
// );
// router.get(
//     "/getAllCompletedEventsCount",
//     eventController.getAllCompletedEventsCount
// );
// router.get(
//     "/getAllOngoingEventsCount",
//     eventController.getAllOngoingEventsCount
// );

// // Get All registered participants in the specific event, which will be shown on the webApp
// router.post(
//     "/getRegisteredParticipants",
//     eventController.getRegisteredParticipants
// );

// // Get All present participants in the specific event, and there will be the generate certificate button when clicked the certificate will be generated for that user.
// router.post("/getPresentParticipants", eventController.getPresentParticipants);

// // Certificate generation
// router.post("/generateCertificate", eventController.generateCertificate);

// //          ------ Frontend  routes ------

// // login route
// router.get("/authority/login-page", authorityController.loginPage);
// // Home page route
// router.get("/", authorityController.homePage);
// // Bio waste routes
// router.get("/biowaste/add-resources-page", biowasteController.addResourcesPage);
// router.get("/biowaste/get-resources-page", biowasteController.getResourcesPage);
// // Events Routes
// router.get("/events/view-all-events", eventController.viewAllEventsPage);
// router.get(
//     "/events/view-upcoming-events",
//     eventController.viewUpcomingEventsPage
// );
// router.get(
//     "/events/view-ongoing-events",
//     eventController.viewOngoingEventsPage
// );
// router.get(
//     "/events/view-completed-events",
//     eventController.viewCompletedEventsPage
// );
// router.get(
//     "/events/view-event-by-id/:eventId",
//     eventController.viewEventsByIdPage
// );
// router.get("/events/add-events-page", eventController.addEventsPage);
// //404

// router.get("*", (req, res) => {
//     res.status(404).send("404: Page not found");
// });

// // ? Item Listing Module (Buy & Sell)
// router.post("/addItem", itemlistingContoller.addItem);
// router.post("/getItemById", itemlistingContoller.getItemById);
// router.get("/getAllItems", itemlistingContoller.getAllItems);
// router.post(
//     "/getAllItemsPostedByUser",
//     itemlistingContoller.getAllItemsPostedByUser
// );
// router.post(
//     "/getItemCountPostedByUser",
//     itemlistingContoller.getItemCountPostedByUser
// );

// // Search API by title (You can also check count of items based on search)
// router.post("/searchItemByTitle", itemlistingContoller.searchItemByTitle);

// // Filters API (You can also check count of items based on filter)
// router.post("/filterByCategory", itemlistingContoller.filterByCategory);
// router.post("/filterByLocation", itemlistingContoller.filterByLocation);

// // Their favorite items
// router.post("/addItemToFav", itemlistingContoller.addItemToFav);
// router.post("/removeItemFromFav", itemlistingContoller.removeItemFromFav);

// // Check if the item is already present in the list or not
// router.post(
//     "/checkIfItemAlreadyExist",
//     itemlistingContoller.checkIfItemAlreadyExist
// );

module.exports = router;
