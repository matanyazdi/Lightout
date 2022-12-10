var timer_start, timer_game, timer_finish, timer_time, good_positions, speed, timerStart, positions;
var lightout_started = false;
var good = 0;

var mode = 4;
var mode_data = {};
mode_data[4] = [5, '119px'];
mode_data[5] = [10, '92px'];
mode_data[6] = [14, '74px'];
mode_data[7] = [18, '61px'];
mode_data[8] = [20, '51px'];
mode_data[9] = [24, '44px'];
mode_data[10] = [28, '38px'];



function toggleState(box) {
	if (box.classList.contains('lightout-unfliped')) {
		box.classList.add('lightout-fliped')
		box.classList.remove('lightout-unfliped')
		good = good + 1;
	} else if(box.classList.contains('lightout-fliped')) {
		box.classList.add('lightout-unfliped')
		box.classList.remove('lightout-fliped')
		good = good - 1;
	}
}

function checkIfGood(timeToEnd) {
	if (good == mode*mode) {
        StopLightoutTimer();
        document.querySelector('.lightout-groups').classList.add('hidden');
        document.querySelector('.lightout-splash').classList.remove('hidden');
        document.querySelector('.lightout-splash .lightout-text').innerHTML = 'BY PASS';
        setTimeout(function() { 
            ResetLightout();
            $.post(`https://lightout/callback`, JSON.stringify({ 'success': true }));
        }, 4000);
		
	}
    if (timeToEnd){
        document.querySelector('.lightout-groups').classList.add('hidden');
        document.querySelector('.lightout-splash').classList.remove('hidden');
        document.querySelector('.lightout-splash .lightout-text').innerHTML = 'ACCESS DENIED';
        setTimeout(function() {
            ResetLightout();
            $.post(`https://lightout/callback`, JSON.stringify({ 'success': false }));
        }, 4000);
    }else {
	    return;
    }
}

function shuffleBoxes(pos) {
    var box = document.querySelectorAll('.lightout-group');
    toggleState(box[pos])
	if (parseInt(pos) >= mode) {
		toggleState(box[parseInt(pos) - mode])
	}
	if (parseInt(pos)%mode >= 1) {
		toggleState(box[parseInt(pos) - 1])
	}
	if (parseInt(pos)%mode <= mode-2){
		toggleState(box[parseInt(pos) + 1])
	}
	if (parseInt(pos)+mode < mode*mode) {
        toggleState(box[parseInt(pos) + mode])
	}
		
}

function LightoutListener(ev){
    if(!lightout_started) return;
    var box = document.querySelectorAll('.lightout-group');
    toggleState(box[(ev.target.dataset.position)])
	if (parseInt(ev.target.dataset.position) >= mode) {
		toggleState(box[parseInt(ev.target.dataset.position) - mode])
	}
	if (parseInt(ev.target.dataset.position)%mode >= 1) {
		toggleState(box[parseInt(ev.target.dataset.position) - 1])
	}
	if (parseInt(ev.target.dataset.position)%mode <= mode-2){
		toggleState(box[parseInt(ev.target.dataset.position) + 1])
	}
	if (parseInt(ev.target.dataset.position)+mode < mode*mode) {
		toggleState(box[parseInt(ev.target.dataset.position) + mode])
	}

    checkIfGood();
}

function AddLightoutListeners(){
    document.querySelectorAll('.lightout-group').forEach(el => {
        el.addEventListener('mousedown', LightoutListener);
    });
}


function ResetLightout() {
    lightout_started = false;

    $(".lightout").fadeOut();

    ResetLightoutTimer();
    clearTimeout(timer_start);
    clearTimeout(timer_game);
    clearTimeout(timer_finish);

    document.querySelector('.lightout-splash').classList.remove('hidden');
    document.querySelector('.lightout-groups').classList.add('hidden');

    document.querySelectorAll('.lightout-group').forEach(el => { el.remove(); });

}

function StartLightout() {
    positions = range(0, Math.pow(mode, 2) - 1 );
    shuffle(positions);
    good_positions = positions.slice(0, 10);
    let div = document.createElement('div');
    div.classList.add('lightout-group');
    div.style.width = mode_data[mode][1];
    div.style.height = mode_data[mode][1];
    const groups = document.querySelector('.lightout-groups');
    for(let i=0; i < positions.length; i++){
        let group = div.cloneNode();
        group.dataset.position = i.toString();
        groups.appendChild(group);
    }

    AddLightoutListeners();

    timer_start = sleep(2000, function(){
        document.querySelector('.lightout-splash').classList.add('hidden');
        document.querySelector('.lightout-groups').classList.remove('hidden');

        let blocks = document.querySelectorAll('.lightout-group');
		blocks.forEach( block => {
            block.classList.add('lightout-unfliped')
		})
        good_positions.forEach( pos => {
            shuffleBoxes(pos)
        })
        lightout_started = true;

        StartLightoutTimer();
        timer_finish = sleep((speed * 1000), function(){
            lightout_started = false;
            checkIfGood(true)
        });
    });
}

function StartLightoutTimer() {
    timerStart = new Date();
    timer_time = setInterval(LightoutTimer, 1);
}

function LightoutTimer() {
    let timerNow = new Date();
    let timerDiff = new Date();
    timerDiff.setTime(timerNow - timerStart);
    let ms = timerDiff.getMilliseconds();
    let sec = timerDiff.getSeconds();
    if (ms < 10) {ms = "00"+ms;}else if (ms < 100) {ms = "0"+ms;}
}

function StopLightoutTimer() {
    clearInterval(timer_time);
}

function ResetLightoutTimer() {
    clearInterval(timer_time);
}

window.addEventListener('message', (event) => {
  if (event.data.action === 'open') {
    speed = event.data.time;
	mode = event.data.mode;
    good = 0;

    $(".lightout").fadeIn();
    document.querySelector('.lightout').classList.remove('hidden');
    document.querySelector('.lightout-splash').classList.remove('hidden');
    document.querySelector('.lightout-splash .lightout-text').innerHTML = 'Network Access Blocked... Override Required';
    sleep(1000, function() {
        StartLightout();
    });
  }
});

document.addEventListener("keydown", function(ev) {
  let key_pressed = ev.key;
  let valid_keys = ['Escape'];

  if (lightout_started && valid_keys.includes(key_pressed)) {
      switch (key_pressed) {
          case 'Escape':
              lightout_started = false;
              game_playing = false;
              ResetLightout();
              $.post(`https://lightout/callback`, JSON.stringify({ 'success': false }));
              $(".lightout").fadeOut();
              break;
      }
  }
});


const sleep = (ms, fn) => {return setTimeout(fn, ms)};

const range = (start, end, length = end - start + 1) => {
    return Array.from({length}, (_, i) => start + i)
}

const random = (min, max) => {
    return Math.floor(Math.random() * (max - min)) + min;
}

const shuffle = (arr) => {
    for (let i = arr.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        const temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}
