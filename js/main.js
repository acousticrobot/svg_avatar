var svg = d3.select("#avatar").append("svg").attr("width", 200).attr("height", 250);

var eyeGroups = _.pluck(avatarGroups.eyes,"title");
var headGroups = _.pluck(avatarGroups.heads,"title");
var crownGroups = _.pluck(avatarGroups.crowns,"title");

var eyeCounter= 0;
var headCounter = 0;
var crownCounter = 0;

function currentEyes() {
  return avatarGroups.eyes[eyeCounter];
}
function currentHead() {
  return avatarGroups.heads[headCounter];
}
function currentCrown() {
  return avatarGroups.crowns[crownCounter];
}

function nextComponent(componentCounter,componentGroup) {
  if (componentCounter >= componentGroup.length - 1 ) {
    componentCounter = 0;
  } else {
    componentCounter ++;
  }
  console.log(componentCounter);
  return componentCounter;
}

var colorThemes = ["athens", "san-paulo"];
var eyeTheme = 0;
var headTheme = 0;
var crownTheme = 0;

function currentEyeTheme() {
  return colorThemes[eyeTheme];
}
function currentHeadTheme() {
  return colorThemes[headTheme];
}
function currentCrownTheme() {
  return colorThemes[crownTheme];
}

function nextTheme(componentTheme) {
  console.log("sam i am");
  if (componentTheme >= colorThemes.length - 1) {
    componentTheme = 0;
  } else {
    componentTheme ++;
  }
  return componentTheme;
}

function assembleShape(shape) {
  return function(){
    var group = d3.select(document.createElementNS(d3.ns.prefix.svg, shape.type));
    for (var key in shape.attr) {
      group.attr(key,shape.attr[key]);
    }
    return group.node();
  }
}

function assembleComponent(componentType,component,theme,x,y) {
  return function(){
    var group = d3.select(document.createElementNS(d3.ns.prefix.svg, 'g'))
                  .attr("transform", "translate("+x+","+y+")")
                  .attr("class",componentType + "-container " + theme);
    for (var i=0; i < component.shapes.length; i++) {
      var shape = assembleShape(component.shapes[i]);
      group.append(shape);
    }
    return group.node();
  }
}


// function assemble() {
//   return function(){
//     var group = d3.select(document.createElementNS(d3.ns.prefix.svg, 'g'))
//                   .attr("class","avatar-container");
//     for (var i=0; i < heads.shapes.length; i++) {

//     }
//     for (var i = 0; i < eyes.shapes.length; i++) {
//       var shape =  assembleShape(eyes.shapes[i]);
//       group.append(shape);
//     }
//     return group.node();
//   }
// }



// initial build
function build () {
  svg.selectAll("g").remove();
  svg.append(assembleComponent("head",currentHead(),currentHeadTheme(),0,50));
  svg.append(assembleComponent("crown",currentCrown(),currentCrownTheme(),0,0));
  svg.append(assembleComponent("eyes",currentEyes(),currentEyeTheme(),0,100));
}

build();


// Wachers
$("#crown-controller .theme").click(function(){
  crownTheme = nextTheme(crownTheme);
  build();
});

$("#crown-controller .next").click(function(){
  crownCounter = nextComponent(crownCounter,crownGroups);
  build();
});

$("#eye-controller .theme").click(function(){
  eyeTheme = nextTheme(eyeTheme);
  build();
});

$("#eye-controller .next").click(function(){
  eyeCounter = nextComponent(eyeCounter,eyeGroups);
  build();
});

$("#head-controller .theme").click(function(){
  eyeTheme = nextTheme(eyeTheme);
  build();
});

$("#head-controller .next").click(function(){
  headCounter = nextComponent(headCounter,headGroups);
  build();
});
