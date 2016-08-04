function styleParcelle(couleur_trait, couleur_plein){
	return new ol.style.Style({
		stroke: new ol.style.Stroke({
			color: couleur_trait,
			lineDash: [4],
			width: 2
		}),
		fill: new ol.style.Fill({
			color: couleur_plein
		})
	});
}

function styleLocal(code_unicode, couleur, taille_px){
	return new ol.style.Style({
		text: new ol.style.Text({
			text: code_unicode,
			font: 'normal ' + taille_px +'px FontAwesome',
			textBaseline: 'Bottom',
			fill: new ol.style.Fill({
				color: couleur,
			})
		})
	})
}

// définition Styles 
var styles_parcelles = {
		// Maison
		'132': styleParcelle('#0066CC', 'rgba(0, 102, 204, 0.2)'),
		// Maisons
		'131': styleParcelle('#660033', 'rgba(102, 0, 51, 0.2)'),
		// Appart - ne doit pas servir à priori 
		'122': styleParcelle('#FF8000', 'rgba(255, 128, 0, 0.2)'),
		// Apparts
		'121': styleParcelle('#990000', 'rgba(153, 0, 0, 0.2)'),
		// Industriel/Commercial
		'111': styleParcelle('#00994C', 'rgba(0, 153, 76, 0.2)'),
		// Dependances
		'142': styleParcelle('#FF3333', 'rgba(255, 102, 102, 0.2)'),
};

var styles_locaux = {
		// Appart
		'122': styleLocal('\uf1ad', '#FF8000', '14'),
		// Apparts
		'121': styleLocal('\uf1ad', '#990000', '14'),
		// Maison
		'132': styleLocal('\uf015', '#0066CC', '18'),
		// Maisons
		'131': styleLocal('\uf015', '#660033', '18'),
		// Industriel/Commercial
		'111': styleLocal('\uf275', '#00994C', '18'),
		// Dependances
		'142': styleLocal('\uf1e1', '#FF3333', '18'),
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
