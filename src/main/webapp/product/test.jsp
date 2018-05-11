<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
/* var chbx = document.createElement("input");
chbx.setAttribute("type", "checkbox");
chbx.setAttribute("id", idValue);
chbx.setAttribute("name", "testCheckBox");
document.body.appendChild(chbx);  */
function addBox() {
	var txt = "<input type=\"checkbox\" name=\"color\" id=\"color\" value=\"free\">";
		txt += "$(\"#color\").val();";
	var area = document.createElement('div');
	area.innerHTML = txt;
	document.getElementById('textBoxArea').appendChild(area);
}
</script>

<form name="frm" id="frm">
<body>
<input type="text" id="color" name="color">
<button type="button" onclick="addBox()">+</button>
<div id="textBoxArea" style="text-align:left;"></div>
</body>
</form>