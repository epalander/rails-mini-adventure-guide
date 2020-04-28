import mapboxgl from 'mapbox-gl';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  // fit map to markers
const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 100, duration: 1000 });
};

  if (mapElement) { // only build a map if there's a div#map to inject into
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
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    });
    // call the function to fit the map to the marker
    fitMapToMarkers(map, markers);
  }
};

export { initMapbox };
