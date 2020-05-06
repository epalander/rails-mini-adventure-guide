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
      style: 'mapbox://styles/epalander/ck9jryk1r0m9e1io4wn5vyhjk'
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
      element.style.width = '17px';
      element.style.height = '25px';

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


export { initMapbox };
