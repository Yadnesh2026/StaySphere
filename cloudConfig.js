const cloudinary = require('cloudinary').v2;
const { CloudinaryStorage } = require('multer-storage-cloudinary');
const multer = require("multer");
const path = require("path");
const fs = require("fs");

cloudinary.config({
    cloud_name: process.env.CLOUD_NAME,
    api_key: process.env.CLOUD_API_KEY,
    api_secret: process.env.CLOUD_API_SECRET 
});

const hasCloudinaryConfig = process.env.CLOUD_NAME && process.env.CLOUD_API_KEY && process.env.CLOUD_API_SECRET;

const storage = hasCloudinaryConfig
  ? new CloudinaryStorage({///To store a image in the folder name staySphere_DEV
      cloudinary: cloudinary,
      params: {
        folder: 'StaySphere_DEV',
        allowed_formats:["png","jpg","jpeg"], // supports promises as well
      },
    })
  : multer.diskStorage({
      destination: (req, file, cb) => {
        const uploadPath = path.join(__dirname, "public", "uploads");
        fs.mkdirSync(uploadPath, { recursive: true });
        cb(null, uploadPath);
      },
      filename: (req, file, cb) => {
        const uniqueName = `${Date.now()}-${file.originalname.replace(/\s+/g, "-")}`;
        cb(null, uniqueName);
      }
    });

module.exports = {
    cloudinary,
    storage,
    hasCloudinaryConfig
}
