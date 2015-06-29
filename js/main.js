var svg = d3.select("#avatar").append("svg").attr("width", 200).attr("height", 300);

var colorThemes = ["athens", "san-paulo", "miami", "phoenix"];

// component = "eyes"
var Component = function(component){
  var type = component;
  var maxGroups = avatarGroups[component].length - 1;
  var groupCounter = _.random(maxGroups);

  var maxThemes = colorThemes.length - 1;
  var themeCounter = _.random(maxThemes);

  var group = function() {
      return avatarGroups[component][groupCounter];
  }
  var theme = function() {
    return colorThemes[themeCounter];
  }
  var nextGroup = function() {
    if (groupCounter >= maxGroups ) {
      groupCounter = 0;
    } else {
      groupCounter ++;
    }
  }
  var lastGroup = function() {
    if (groupCounter <= 0 ) {
      groupCounter = maxGroups;
    } else {
      groupCounter --;
    }
  }
  var nextTheme = function() {
    if (themeCounter >= maxThemes) {
      themeCounter = 0;
    } else {
      themeCounter ++;
    }
  }
  return {
    type: type,
    group: group,
    theme: theme,
    nextGroup: nextGroup,
    nextTheme: nextTheme,
    lastGroup: lastGroup
  }
}

var eyes = new Component("eyes");
var head = new Component("heads");
var crown = new Component("crowns");
var mouth = new Component("mouths");

function assembleShape(shape) {
  return function(){
    var group = d3.select(document.createElementNS(d3.ns.prefix.svg, shape.type));
    for (var key in shape.attr) {
      group.attr(key,shape.attr[key]);
    }
    return group.node();
  }
}

function assembleComponent(component,x,y) {
  return function(){
    var group = d3.select(document.createElementNS(d3.ns.prefix.svg, 'g'))
                  .attr("transform", "translate("+x+","+y+")")
                  .attr("class",component.type + "-container " + component.theme());
    for (var i=0; i < component.group().shapes.length; i++) {
      var shape = assembleShape(component.group().shapes[i]);
      group.append(shape);
    }
    return group.node();
  }
}

function build () {
  svg.selectAll("g").remove();
  svg.append(assembleComponent(head,0,100));
  svg.append(assembleComponent(crown,0,0));
  svg.append(assembleComponent(eyes,0,100));
  svg.append(assembleComponent(mouth,0,150));
}

// initial build
build();

// Wachers
d3.select("#crown-controller .last").on("click", function() {
  crown.lastGroup();
  build();
})

$("#crown-controller .theme").click(function(){
  crown.nextTheme();
  build();
});
$("#crown-controller .next").click(function(){
  crown.nextGroup();
  build();
});

$("#eye-controller .last").click(function(){
  eyes.lastGroup();
  build();
});
$("#eye-controller .theme").click(function(){
  eyes.nextTheme();
  build();
});
$("#eye-controller .next").click(function(){
  eyes.nextGroup();
  build();
});

$("#head-controller .last").click(function(){
  head.lastGroup();
  build();
});
$("#head-controller .theme").click(function(){
  head.nextTheme();
  build();
});
$("#head-controller .next").click(function(){
  head.nextGroup();
  build();
});

$("#mouth-controller .last").click(function(){
  mouth.lastGroup();
  build();
});
$("#mouth-controller .theme").click(function(){
  mouth.nextTheme();
  build();
});
$("#mouth-controller .next").click(function(){
  mouth.nextGroup();
  build();
});
