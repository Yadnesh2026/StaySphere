const Listing = require("../models/listing");
const TripPlan = require("../models/tripPlan");

const cityGuides = {
  mumbai: {
    attractions: ["Gateway of India", "Marine Drive", "Juhu Beach", "Bandra Fort", "Colaba Causeway"],
    foodPerGuestPerDay: 900,
    travelPerDay: 1200
  },
  pune: {
    attractions: ["Shaniwar Wada", "Aga Khan Palace", "Sinhagad Fort", "FC Road", "Koregaon Park"],
    foodPerGuestPerDay: 700,
    travelPerDay: 900
  },
  goa: {
    attractions: ["Baga Beach", "Fort Aguada", "Anjuna Market", "Dona Paula", "Old Goa Churches"],
    foodPerGuestPerDay: 1000,
    travelPerDay: 1400
  },
  delhi: {
    attractions: ["India Gate", "Red Fort", "Qutub Minar", "Lotus Temple", "Chandni Chowk"],
    foodPerGuestPerDay: 850,
    travelPerDay: 1100
  },
  jaipur: {
    attractions: ["Hawa Mahal", "Amber Fort", "City Palace", "Nahargarh Fort", "Johri Bazaar"],
    foodPerGuestPerDay: 750,
    travelPerDay: 1000
  },
  bengaluru: {
    attractions: ["Cubbon Park", "Lalbagh", "Bangalore Palace", "Church Street", "UB City"],
    foodPerGuestPerDay: 850,
    travelPerDay: 1000
  }
};

const defaultGuide = {
  attractions: ["City center", "Local market", "Popular cafe street", "Museum or heritage site", "Evening viewpoint"],
  foodPerGuestPerDay: 750,
  travelPerDay: 900
};

function buildPlan({ city, days, guests, budget, listings }) {
  const normalizedCity = city.trim().toLowerCase();
  const guide = cityGuides[normalizedCity] || defaultGuide;
  const safeDays = Math.max(Number(days) || 1, 1);
  const safeGuests = Math.max(Number(guests) || 1, 1);
  const safeBudget = Math.max(Number(budget) || 0, 0);

  const averageStayPrice = listings.length
    ? Math.round(listings.reduce((total, listing) => total + (listing.price || 0), 0) / listings.length)
    : 0;

  const stayBudget = averageStayPrice * safeDays;
  const foodBudget = guide.foodPerGuestPerDay * safeGuests * safeDays;
  const travelBudget = guide.travelPerDay * safeDays;
  const totalEstimate = stayBudget + foodBudget + travelBudget;

  const itinerary = Array.from({ length: safeDays }, (_, index) => {
    const day = index + 1;
    const firstPlace = guide.attractions[index % guide.attractions.length];
    const secondPlace = guide.attractions[(index + 1) % guide.attractions.length];

    return {
      day,
      title: day === 1 ? "Arrival and local exploring" : `Explore ${city}`,
      plan: [
        day === 1 ? "Check in and settle at your stay" : "Start with breakfast near your stay",
        `Visit ${firstPlace}`,
        `Spend evening around ${secondPlace}`
      ]
    };
  });

  return {
    city,
    days: safeDays,
    guests: safeGuests,
    budget: safeBudget,
    attractions: guide.attractions,
    itinerary,
    listings,
    stayBudget,
    foodBudget,
    travelBudget,
    totalEstimate,
    budgetMessage: safeBudget === 0
      ? "Add a budget to compare it with the estimate."
      : totalEstimate <= safeBudget
        ? "This plan fits inside your budget."
        : "This plan is above your budget. Try fewer days or cheaper stays."
  };
}

module.exports.renderPlanner = (req, res) => {
  res.render("planner/index.ejs", { plan: null, formData: {} });
};

module.exports.createPlanner = async (req, res) => {
  const { city = "", days = 1, guests = 1, budget = 0 } = req.body.trip || {};

  const listings = await Listing.find({
    location: new RegExp(city, "i"),
    availability: { $in: ["available", null] }
  }).limit(6);

  const plan = buildPlan({ city, days, guests, budget, listings });

  res.render("planner/index.ejs", {
    plan,
    formData: { city, days, guests, budget }
  });
};

module.exports.savePlanner = async (req, res) => {
  const { city, days, guests, budget, stayBudget, foodBudget, travelBudget, attractions, itinerary, listings } = req.body.plan;

  const parsedAttractions = JSON.parse(attractions || "[]");
  const parsedItinerary = JSON.parse(itinerary || "[]");
  const parsedListings = JSON.parse(listings || "[]");

  await TripPlan.create({
    user: req.user._id,
    city,
    days,
    guests,
    budget,
    stayBudget,
    foodBudget,
    travelBudget,
    attractions: parsedAttractions,
    itinerary: parsedItinerary,
    listings: parsedListings
  });

  req.flash("success", "Trip plan saved!");
  res.redirect("/planner/saved");
};

module.exports.savedPlans = async (req, res) => {
  const plans = await TripPlan.find({ user: req.user._id })
    .populate("listings")
    .sort({ createdAt: -1 });

  res.render("planner/saved.ejs", { plans });
};
