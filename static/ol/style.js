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
          font: 'normal ' + taille_px + 'px FontAwesome',
          fill: new ol.style.Fill({
            color: couleur
          }),         
        })
      });
}

// définition Styles 
var styles_parcelles = {
		// Activité
		'14': styleParcelle('#333300', 'rgba(51, 51, 0, 0.2)'),
		// Maison
		'11': styleParcelle('#0066CC', 'rgba(0, 102, 204, 0.2)'),
		// Dépendance
		'13': styleParcelle('#660033', 'rgba(102, 0, 51, 0.2)'),		
		// Appartement 
		'12': styleParcelle('#FF8000', 'rgba(255, 128, 0, 0.2)'),
		// Bati indéterminé
		'10': styleParcelle('#990000', 'rgba(153, 0, 0, 0.2)'),
		// Bati Mixte
		'15': styleParcelle('#00994C', 'rgba(0, 153, 76, 0.2)'),
		// Terrains Naturels
		'23': styleParcelle('#32CD32', 'rgba(50, 205, 50, 0.2)'), 	
		// Terrains artificialisés
		'22': styleParcelle('#BDB76B', 'rgba(189, 183, 107, 0.2)'),
		// Terrains type TAB
		'21': styleParcelle('#556B2F', 'rgba(85, 107, 47, 0.2)'),
		// Terrains non déterminés
		'20': styleParcelle('#C0C0C0', 'rgba(192, 192, 192, 0.2)'),		
};

var styles_locaux = {
		// Activité
		'14': styleLocal('\uf275', '#333300', '14'),
		// Maison
		'11': styleLocal('\uf015', '#0066CC', '14'),
		// Dépendance
		'13': styleLocal('\uf1e1', '#660033', '14'),		
		// Appartement 
		'12': styleLocal('\uf1ad', '#FF8000', '14'),
		// Bati indéterminé
		'10': styleLocal('\uf059', '#990000', '14'),
		// Bati Mixte
		'15': styleLocal('\uf275','#00994C', '14'),
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
	return styles_parcelles[feature.get('codtypbien').substring(0,2)];
};

var fct_styleLocaux = function(feature) {
	return styles_locaux[feature.get('codtypbien').substring(0,2)];
};
