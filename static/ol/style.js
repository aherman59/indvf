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
		/*
		text: new ol.style.Text({
			text: 'O',
			font: '' + taille_px +'px helvetica,sans-serif',
			textBaseline: 'Bottom',
			fill: new ol.style.Fill({
				color: couleur,
			})
		})
		*/
		text: new ol.style.Text({
	         font: '12px Arial,sans-serif',
	         text: 'i',
	         fill: new ol.style.Fill({
					color: couleur,
				}),
	       })
	})
}

// définition Styles 
var styles_parcelles = {
		// Vefa
		'31': styleParcelle('#333300', 'rgba(51, 51, 0, 0.2)'),
		'32': styleParcelle('#333300', 'rgba(51, 51, 0, 0.2)'),
		'33': styleParcelle('#333300', 'rgba(51, 51, 0, 0.2)'),
		'34': styleParcelle('#333300', 'rgba(51, 51, 0, 0.2)'),
		// Maison
		'1110': styleParcelle('#0066CC', 'rgba(0, 102, 204, 0.2)'),
		'1111': styleParcelle('#0066CC', 'rgba(0, 102, 204, 0.2)'),
		'1112': styleParcelle('#0066CC', 'rgba(0, 102, 204, 0.2)'),
		'1113': styleParcelle('#0066CC', 'rgba(0, 102, 204, 0.2)'),
		'1114': styleParcelle('#0066CC', 'rgba(0, 102, 204, 0.2)'),
		// Maisons
		'131': styleParcelle('#660033', 'rgba(102, 0, 51, 0.2)'),		
		// Appart - ne doit pas servir à priori 
		'12110': styleParcelle('#FF8000', 'rgba(255, 128, 0, 0.2)'),
		// Apparts
		'121': styleParcelle('#990000', 'rgba(153, 0, 0, 0.2)'),
		// Industriel/Commercial
		'112': styleParcelle('#00994C', 'rgba(0, 153, 76, 0.2)'),
		// Logement + Industriel/Commercial
		'111': styleParcelle('#0066CC', 'rgba(0, 153, 76, 0.2)'),
		// Dependances
		'142': styleParcelle('#FF3333', 'rgba(255, 102, 102, 0.2)'),
		// Terrains à Batir
		'25': styleParcelle('#660066', 'rgba(102, 0, 102, 0.2)'),
		// Terrains Forestiers
		'212': styleParcelle('#32CD32', 'rgba(50, 205, 50, 0.2)'), 	
		// Terrains Agricoles
		'213': styleParcelle('#00CCCC', 'rgba(0, 204, 204, 0.2)'),
		// Terrains naturels
		'211': styleParcelle('#D2691E', 'rgba(210, 105, 30, 0.2)'),
		// Terrains artificialisés
		'221': styleParcelle('#BDB76B', 'rgba(189, 183, 107, 0.2)'),
		// Terrains mixtes
		'231': styleParcelle('#556B2F', 'rgba(85, 107, 47, 0.2)'),
		// Terrains non déterminés
		'241': styleParcelle('#C0C0C0', 'rgba(192, 192, 192, 0.2)'),		
};

var styles_locaux = {
		// Appart
		'12110': styleLocal('\uf1ad', '#FF8000', '14'),
		'12111': styleLocal('\uf1ad', '#FF8000', '14'),
		'12112': styleLocal('\uf1ad', '#FF8000', '14'),
		'12113': styleLocal('\uf1ad', '#FF8000', '14'),
		'12114': styleLocal('\uf1ad', '#FF8000', '14'),
		// Apparts
		'121': styleLocal('\uf1ad', '#990000', '14'),
		// Vefa - Appart(s)
		'32': styleLocal('\uf1ad', '#333300', '14'),
		// Maison
		'1110': styleLocal('T', '#0066CC', '10'),
		'1111': styleLocal('T', '#0066CC', '10'),
		'1112': styleLocal('T', '#0066CC', '10'),
		'1113': styleLocal('T', '#0066CC', '10'),
		'1114': styleLocal('T', '#0066CC', '10'),
		// Maisons
		'131': styleLocal('\uf015', '#660033', '18'),
		// Vefa - Maison(s)
		'33': styleLocal('\uf015', '#333300', '18'),
		// Industriel/Commercial
		'112': styleLocal('\uf275', '#00994C', '18'),
		// Logement + Industriel/Commercial
		'111': styleLocal('\uf275', '#0066CC', '18'),
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
