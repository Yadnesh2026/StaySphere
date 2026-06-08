const express = require("express");
const router = express.Router();
const wrapAsync = require("../utils/wrapAsync");
const { isLoggedIn } = require("../middleware");
const plannerController = require("../controllers/planner");

router.route("/")
  .get(plannerController.renderPlanner)
  .post(wrapAsync(plannerController.createPlanner));

router.get("/saved", isLoggedIn, wrapAsync(plannerController.savedPlans));
router.post("/save", isLoggedIn, wrapAsync(plannerController.savePlanner));

module.exports = router;
