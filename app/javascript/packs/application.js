// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { initMapbox } from "../plugins/init_mapbox";
import { initAutocomplete } from "../plugins/init_autocomplete";

document.addEventListener("turbolinks:load", () => {
  // Call your functions here, e.g:
  // initSelect2();
  initMapbox();
  initAutocomplete();
});

// Image Gallery

const carouselContainer = document.querySelector(".carousel-container");
const listImageArea = carouselContainer.querySelector(".next-list");
const listOfImages = listImageArea.querySelectorAll("img");
const currentImage = carouselContainer.querySelector(".current-image");
const arrowLeft = carouselContainer.querySelector(".arrow-left");
const arrowRight = carouselContainer.querySelector(".arrow-right");

function styleList() {
  if (listImageArea.scrollWidth == listImageArea.offsetWidth) {
    listImageArea.style.justifyContent = "center";
  } else {
    listImageArea.style.justifyContent = "flex-start";
  }
}

function goToRight() {
  let current = listImageArea.querySelector(".current-image-list");
  current.parentElement.nextElementSibling.children[0].classList.add(
    "current-image-list"
  );
  current.classList.remove("current-image-list");
  current = listImageArea.querySelector(".current-image-list");
  listImageArea.scrollLeft = current.offsetLeft;
  currentImage.attributes.src.value = current.attributes.src.value;
  currentImage.classList.add("slideInFromRight");
  setTimeout(() => {
    currentImage.classList.remove("slideInFromRight");
  }, 500);
}

function goToLeft() {
  let current = listImageArea.querySelector(".current-image-list");
  current.parentElement.previousElementSibling.children[0].classList.add(
    "current-image-list"
  );
  current.classList.remove("current-image-list");
  current = listImageArea.querySelector(".current-image-list");
  listImageArea.scrollLeft = current.offsetLeft;
  currentImage.attributes.src.value = current.attributes.src.value;
  currentImage.classList.add("slideInFromLeft");
  setTimeout(() => {
    currentImage.classList.remove("slideInFromLeft");
  }, 500);
}

function changeCurrentImage(newImage) {
  currentImage.classList.add("fadeIn");
  setTimeout(() => {
    currentImage.classList.remove("fadeIn");
  }, 500);
  currentImage.attributes.src.value = this.attributes.src.value;
  listOfImages.forEach((image) => {
    image.classList.remove("current-image-list");
  });
  this.classList.add("current-image-list");
}

styleList();

arrowLeft.addEventListener("click", goToLeft);
arrowRight.addEventListener("click", goToRight);

window.addEventListener("resize", (e) => {
  styleList();
});

(function () {
  if (typeof NodeList.prototype.forEach === "function") return false;
  NodeList.prototype.forEach = Array.prototype.forEach;
})();

listOfImages.forEach((image) => {
  image.addEventListener("click", changeCurrentImage);
});

// Support component names relative to this directory:
var componentRequireContext = require.context("components", true);
var ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);
