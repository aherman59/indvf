// définition Styles Polygones / Multi-polygones
var styles = {        
		'MultiPolygon': new ol.style.Style({
			stroke: new ol.style.Stroke({
				color: 'blue',
				lineDash: [4],
				width: 2
			}),
			fill: new ol.style.Fill({
				color: 'rgba(255, 255, 0, 0.1)'
			})
		}),
		'Polygon': new ol.style.Style({
			stroke: new ol.style.Stroke({
				color: 'blue',
				lineDash: [4],
				width: 2
			}),
			fill: new ol.style.Fill({
				color: 'rgba(255, 255, 0, 0.1)'
			})
		}),
};

var styleFunction = function(feature) {
    return styles[feature.getGeometry().getType()];
};