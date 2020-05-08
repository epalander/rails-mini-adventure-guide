import mapboxgl from 'mapbox-gl';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

// fit map to markers
const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 75, maxZoom: 10, duration: 2000 });
};

// map
  if (mapElement) {
    // login
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

    // create map
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/epalander/ck9x6kd7c0slg1io7d7jz1k3o'
    });

    // add the markers
    const markers = JSON.parse(mapElement.dataset.markers);

    markers.forEach((marker) => {

      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

      // Create a HTML element for your custom marker
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '19px';
      element.style.height = '30px';

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(element)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(map);
    });

    // call the function to fit the map to the marker
    fitMapToMarkers(map, markers);

  };
};

// const addressInput = document.getElementById("adventure_address");

// if (addressInput) {
//   const places = require('places.js');
//   const placesAutocomplete = places({
//     container: addressInput
//   });
// }

export { initMapbox };
