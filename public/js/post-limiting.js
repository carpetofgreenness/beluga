$("#rem-char").text("150")
function countChar(val) {
	var rem_char = 150-val.value.length;
	$("#rem-char").text(rem_char)
};