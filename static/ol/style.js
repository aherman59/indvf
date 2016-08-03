// définition Styles 
var styles_parcelles = {
		// Appart - ne doit pas servir 
		'122': new ol.style.Style({
			stroke: new ol.style.Stroke({
				color: 'red',
				lineDash: [4],
				width: 2
			}),
			fill: new ol.style.Fill({
				color: 'rgba(255, 0, 0, 0.2)'
			})
		}),
		// Maison
		'132': new ol.style.Style({
			stroke: new ol.style.Stroke({
				color: 'blue',
				lineDash: [4],
				width: 2
			}),
			fill: new ol.style.Fill({
				color: 'rgba(0, 0, 255, 0.2)'
			})
		}),
};

var styles_locaux = {
		// Appart
		'122': new ol.style.Style({
			text: new ol.style.Text({
				text: '\uf1b2',
				font: 'normal 18px FontAwesome',
				textBaseline: 'Bottom',
				fill: new ol.style.Fill({
					color: 'red',
				})
			})
		}),
		// Maison
		'132': new ol.style.Style({
			text: new ol.style.Text({
				text: '\uf015',
				font: 'normal 18px FontAwesome',
				textBaseline: 'Bottom',
				fill: new ol.style.Fill({
					color: 'blue',
				})
			})
		}),
};

var fct_styleParcellaire = function(feature) {
	return new ol.style.Style({
		stroke: new ol.style.Stroke({
			color: 'gray',
			lineDash: [4],
			width: 1.25
		})
	})
};

var fct_styleParcelles = function(feature) {
	return styles_parcelles[feature.get('codtypbien')]
};

var fct_styleLocaux = function(feature) {
	return styles_locaux[feature.get('codtypbien')]
};
