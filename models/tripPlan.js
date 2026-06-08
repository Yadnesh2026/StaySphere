const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const tripPlanSchema = new Schema(
  {
    user: {
      type: Schema.Types.ObjectId,
      ref: "User",
      required: true
    },
    city: {
      type: String,
      required: true
    },
    days: {
      type: Number,
      required: true,
      min: 1
    },
    guests: {
      type: Number,
      required: true,
      min: 1
    },
    budget: {
      type: Number,
      default: 0
    },
    stayBudget: {
      type: Number,
      default: 0
    },
    foodBudget: {
      type: Number,
      default: 0
    },
    travelBudget: {
      type: Number,
      default: 0
    },
    attractions: [String],
    itinerary: [
      {
        day: Number,
        title: String,
        plan: [String]
      }
    ],
    listings: [
      {
        type: Schema.Types.ObjectId,
        ref: "Listing"
      }
    ]
  },
  { timestamps: true }
);

const TripPlan = mongoose.model("TripPlan", tripPlanSchema);
module.exports = TripPlan;
