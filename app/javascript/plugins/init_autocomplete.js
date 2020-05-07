import places from 'places.js';

// // const initAutocomplete = () => {
// //   const addressInput = document.getElementById("adventure_address");
// //   if (addressInput) {
// //     places({ container: addressInput });
// //   }
// // };

// // export { initAutocomplete };

const initAutocomplete = () => {
  const addressInput = document.getElementById("adventure_address");

  if (addressInput) {
    const places = require('places.js');
    const placesAutocomplete = places({
      container: addressInput
    });
  }
};

export { initAutocomplete };
