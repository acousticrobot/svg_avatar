var svg = d3.select("#avatar").append("svg").attr("width", 200).attr("height", 200);



eyeGroups = ["eyes1", "eyes2"]
var iEyes = 0;

function currentEyes() {
  return avatarGroups[eyeGroups[iEyes]];
}


var colorThemes = ["athens", "san-paulo"];
var iThemes = 0;

function assemblePath (path) {
  return function(){
    var group = d3.select(document.createElementNS(d3.ns.prefix.svg, path.type));
    for (var key in path.attr) {
      group.attr(key,path.attr[key]);
    }
    return group.node();
  }
}

function assembleEyes(){
  var eyes = currentEyes();
  return function(){
    var group = d3.select(document.createElementNS(d3.ns.prefix.svg, 'g'))
                  .attr("transform", "translate(0,100)")
                  .attr("class","avatar-eyes " + colorThemes[iThemes]);
    for (var i = 0; i < eyes.paths.length; i++) {
      var path =  assemblePath(eyes.paths[i]);
      group.append(path);
    }
    return group.node();
  }
}

// initial build
svg.append(assembleEyes());


// Wachers
$("#eyes-controller .theme").click(function(){
  if (iThemes == colorThemes.length - 1) {
    iThemes = 0
  } else {
    iThemes ++;
  }
  svg.select(".avatar-eyes").remove();
  svg.append(assembleEyes());
});

$("#eyes-controller .next").click(function(){
  if (iEyes == eyeGroups.length - 1) {
    iEyes = 0
  } else {
    iEyes ++;
  }
  svg.select(".avatar-eyes").remove();
  svg.append(assembleEyes());
});
