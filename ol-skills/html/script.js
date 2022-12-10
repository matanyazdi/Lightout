var timeout;
var opened;
var level;
var xp;

function closeMenu() {
  $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
  $("#main_container").fadeOut(400);
  timeout = setTimeout(function () {
    $("#main_container").html("");
    $("#main_container").fadeIn();
  }, 400);
}

function compare( a, b ) {
  if ( a.name < b.name ){
    return -1;
  }
  if ( a.name > b.name ){
    return 1;
  }
  return 0;
}

function openCategory(skills) {
  var Skills = [];
  for (const [key, value] of Object.entries(skills)) {
    var obj = {
        name: value.name,
        level: value.level,
        xp: value.xp,
        img: value.img,
        desc: value.desc,
        lvldesc: value.lvldesc
      }
    Skills.push(obj);  
  }

  skills.sort( compare );
  opened = '';
  var first = '';
  var base = '<div class="" id="page"><!-- group -->' +
    '   <div class="clearfix grpelem scale-up-center" id="pu104-4"><!-- column -->' +
    '    <div class="clearfix colelem" id="u104-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter" data-leftAdjustmentDoneBy="pu104-4"><!-- content -->' +
    '     <p>SKILLS</p>' +
    '    </div>' +
    '<div class="clearfix colelem" id="u139-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter" data-leftAdjustmentDoneBy="pu104-4"><!-- content -->' +
    '    </div>' +
    '    <div class="colelem" id="u136" data-sizePolicy="fixed" data-pintopage="page_fixedCenter" data-leftAdjustmentDoneBy="pu104-4"><!-- simple frame --></div>' +
    '    <div class="colelem" id="u107" data-sizePolicy="fixed" data-pintopage="page_fixedCenter" data-leftAdjustmentDoneBy="pu104-4"><!-- simple frame --></div>' +
    '<div id="recepies">';
  for (const [key, value] of Object.entries(skills)) {
    first = first + '    <div class="clearfix colelem recipe" data-category="' + value.name + '" onclick="inspect(\''+value.name+'\',\''+value.desc+'\',\''+value.lvldesc+'\',\''+value.level+'\',\''+value.xp+'\')" id="pu212"><!-- group -->' +
      '     <div class="gradient grpelem" id="u212" data-sizePolicy="fixed" data-pintopage="page_fixedCenter" data-leftAdjustmentDoneBy="pu212"><!-- simple frame --></div>' +
      '     <div class="clearfix grpelem" id="u225-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter" data-leftAdjustmentDoneBy="pu212"><!-- content -->' +
      '      <p style="float: left; margin-left: 15px;">' + value.name + '</p>' +
      '     </div>' +
      '     <div class="museBGSize grpelem" id="u264""><i class="' + value.img + '" style="font-size:65px; color:white"></i><!-- simple frame --></div>' +
      '    </div>';
  }
  base = base + first + '</div>' +
    '   </div>' +
    '   <div class="verticalspacer" data-offset-top="0" data-content-above-spacer="1060" data-content-below-spacer="0" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"></div>' +
    '   <div class="grpelem" id="u559"><!-- simple frame --></div>' +
    '  </div>';
  $("#main_container").append(base);
  $("#u139-4").text(1 + ' LEVEL');
  setProgress((0 % 100))

  $(".recipe").hover(function () {
    playClickSound();
  });

}

$(document).keyup(function (e) {
  if (e.keyCode === 27) {
    closeMenu();
  }
});


function inspect(name, desc, lvldesc, cardlvl, cardxp) {
  if (opened != name) {
    opened = name
    lvl = cardlvl
    xp = cardxp
    $("#pu386").remove();
      var base = '   <div class="slide-bottom " id="pu386"><!-- group -->' +
        '    <div class="gradient grpelem" id="u386" data-sizePolicy="fixed" data-pintopage="page_fixedCenter" data-leftAdjustmentDoneBy="pu386"><!-- simple frame --></div>' +

        '    <div class="clearfix grpelem" id="u457-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter" data-leftAdjustmentDoneBy="pu386"><!-- content -->' +
        '     <p>' + name.toUpperCase() + '</p>' + 
        '    </div>' +
        '    <div class="clearfix grpelem" id="u541-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter" data-leftAdjustmentDoneBy="pu386"><!-- content -->' +
        '     <p style="margin-left: -5%;margin-bottom: 5%;">Description:</p>' +
        '    <div class="clearfix grpelem" id="u541-5" data-sizePolicy="fixed" data-pintopage="page_fixedCenter" data-leftAdjustmentDoneBy="pu386"><!-- content -->' +
        '     <p style="margin-left: -5%;margin-bottom: 20%;"> - ' + desc + '</p>' +
        '    </div>' +
        '    <div class="clearfix grpelem" id="u542-4" data-sizePolicy="fixed" data-pintopage="page_fixedCenter" data-leftAdjustmentDoneBy="pu386"><!-- content -->' +
        '     <p style="margin-left: -14%;margin-bottom: 5%;">How to level up:</p>' +
        '    <div class="clearfix grpelem" id="u542-5" data-sizePolicy="fixed" data-pintopage="page_fixedCenter" data-leftAdjustmentDoneBy="pu386"><!-- content -->' +
        '     <p style="margin-left: -16%;"> - ' + lvldesc + '</p>' +
        '    </div>' +

        '<div id="ingredients">';
      


      base =  base + '</div>' +

        '   </div>';
      $("#page").append(base);
      $("#u139-4").text(lvl + ' LEVEL');
      setProgress((xp % 100))
  }
}

function setProgress(p) {
  var prog = (398 / 100) * p;
  $("#u136").animate({
    width: prog
  }, 1000, function () {
  });

}

function playClickSound() {
  var audio = document.getElementById("clickaudio");
  audio.volume = 0.05;
  audio.play();
}
window.addEventListener('message', function (event) {
  var data = event.data;

  if (data.type == "open") {
    openCategory(data.skills);
  }
});