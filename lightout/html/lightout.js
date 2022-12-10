
function mouseOver(e) {
	var idx = getEventId(e);
	curCell = idx;
}

function mouseOut(e) {
	var idx = getEventId(e);
	curCell = -1;
}

var timerID = 0;
var tstart = null;
var killTimer = false;

function updateTimer() {
	if (timerID) clearTimeout(timerID);
	if (!tstart) tstart = new Date();
	if (killTimer) return;

	var tdate = new Date();
	var tdiff = tdate.getTime() - tstart.getTime();

	var min = Math.floor(tdiff/60000), sec = Math.floor(tdiff/1000-60*min);
	var frmt = min + (sec > 9 ? ":" : ":0") + sec;
	document.getElementById('timer').innerHTML = "Time " + frmt;

	timerID = setTimeout("updateTimer()", 1000);
}

function initAfterGrid() {
	tstart = new Date();
	timerID = setTimeout("updateTimer()", 1000);
}

function toggleState(idx) {
	var ch;
	if (idx < 0) return false;
	if (idx >= width*height) return false;
	if (curpuz.charAt(idx) == ' ') {
		backColors[idx] = "#999";
		ch = '#';
	} else {
		backColors[idx] = "#FFF";
		ch = ' ';
	}
	celltds[idx].style.backgroundColor = backColors[idx];
	curpuz = curpuz.substr(0, idx) + ch + curpuz.substr(idx+1);

	return curpuz.indexOf(' ') == -1;
}

function mouseClick(e) {
	var idx = getEventId(e);
	if (curCell != idx) return true;
	if (idx == prevClick) {
		curMoves--;
		prevClick = -1;
	} else {
		moveArr[curMoves++] = idx;
		prevClick = idx;
	}
	document.getElementById('moves').innerHTML = "Moves: " + curMoves;
	if (idx >= width) toggleState(idx-width);
	if (idx%width >= 1) toggleState(idx-1);
	if (idx%width <= width-2) toggleState(idx+1);
	if (idx+width < height*width) toggleState(idx+width);
	if (toggleState(idx)) {
		killTimer = true;
		puzzleDone();
		console.log('congrate');
	}
	return false;
}


window.addEventListener('message', function(event){
    if (event.data.action == "open") {
        console.log('as')
        $(".lightout").fadeIn()
        initAfterGrid()
    }
})
