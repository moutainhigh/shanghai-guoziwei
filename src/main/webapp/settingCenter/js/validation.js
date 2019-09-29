function notNumber(strValue) {
	if (strValue == "")
		return false;
	var pattern = /^\d*$/;
	if (pattern.test(strValue))
		return false;
	else
		return true;
}
/*
 * ================================================================== �Ƿ�Ϊ��
 * ==================================================================
 */
function isEmpty(strValue) {
	strValue = strValue.replace(/^\s+|\s+$/g, "");
	return (strValue == null || strValue == "");
}

/*
 * ================================================================== �Ƿ�Ϊ��������
 * ==================================================================
 */
function isPositive(strValue) {
	return isInt(strValue, "+") || isFloat(strValue, "+");
}

/*
 * ================================================================== �Ƿ�Ϊ��������
 * ==================================================================
 */
function isNegative(strValue) {
	return isInt(strValue, "-") || isFloat(strValue, "-");
}

/*
 * ==================================================================
 * �ж�objStr�Ƿ�Ϊ�Ϸ���Email��ַ
 * ==================================================================
 */
function isValidEmail(objStr) {
	if (objStr == "")
		return false;
	var reg = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;
	objStr = objStr.toString();
	return (objStr.match(reg) != null);
}

/*
 * ==================================================================
 * �ж�objStr�Ƿ�Ϊ�Ϸ�������(yyyy-MM-dd)����(yy-MM-dd)
 * ==================================================================
 */
function isDate(objStr) {
	var reg = /^((\d{4})|(\d{2}))-(\d{1,2})-(\d{1,2})$/;

	if (trim(objStr) == "")
		return false;
	else
		objStr = objStr.toString();

	if (objStr.match(reg) == null)
		return false;

	var arrDate = objStr.split("-");

	var year = parseInt(arrDate[0], 10);
	var month = parseInt(arrDate[1], 10);
	var day = parseInt(arrDate[2], 10);

	if (year < 100)
		if (year < 50)
			year += 2000;
		else
			year += 1900;

	var date = new Date(year, month - 1, day);
	var y = parseInt(date.getYear(), 10);
	// ��������19**��Date.getYear()���ص���ĩ��λ������Ϊ��ݣ�����һ��Ҫ����1900������ȷ�����
	if (y < 100)
		y += 1900;

	if ((y == year && parseInt(date.getMonth(), 10) == month - 1 && parseInt(
			date.getDate(), 10) == day)
			&& year >= 1900 && year <= 2049)
		return true;
	else
		return false;
}

/*
 * ================================================================== (�����ַ���,
 * sign(+��-��empty)��zero(empty��1��true) �ж��Ƿ�Ϊ����������������������������+0��������+0
 * ==================================================================
 */
function isInt(objStr, sign, zero) {
	var reg;
	var bolzero;

	if (trim(objStr) == "")
		return false;
	else
		objStr = objStr.toString();

	if ((sign == null) || (trim(sign) == ""))
		sign = "+-";

	if ((zero == null) || (trim(zero) == ""))
		bolzero = false;
	else {
		zero = zero.toString();
		bolzero = (zero == "true" || zero == "1");
	}

	switch (sign) {
		case "+-" :
			// ����
			reg = /(^-?|^\+?)\d+$/;
			break;
		case "+" :
			if (!bolzero)
				// ������
				reg = /^\+?[0-9]*[1-9][0-9]*$/;
			else {
				// ������+0
				// reg=/^\+?\d+$/;
				reg = /^\+?[0-9]*[0-9][0-9]*$/;
			}
			break;
		case "-" :
			if (!bolzero)
				// ������
				reg = /^-[0-9]*[1-9][0-9]*$/;
			else
				// ������+0
				// reg=/^-\d+$/;
				reg = /^-[0-9]*[0-9][0-9]*$/;
			break;
		default :
			alert("�����Ų�����ֻ��Ϊ(�ա�+��-)");
			return false;
			break;
	}

	return (objStr.match(reg) != null);
}

/*
 * isFloat2(objStr, iDigit):�ж�objStr�Ƿ�Ϊ����������С��λ��С�ڵ���vDigit
 */
function isFloat2(objStr, iDigit, num) {
	num = num ? ("{1," + num + "}") : "*"
	var strReg = "^(-?|\\+?)(\\d" + num + "?)(\\.\\d{1,";
	// var reg=/^(-?|\+?)(0|[1-9]\d*?)(\.\d{1,10})?$/;
	strReg += iDigit;
	strReg += "})?$";
	if (trim(objStr) == "")
		return false;
	else
		objStr = objStr.toString();

	var reg = new RegExp(strReg);
	return (objStr.match(reg) != null);
}

/*
 * ================================================================== (�����ַ���,
 * sign(+��-��empty)��zero(empty��1��true) �ж��Ƿ�Ϊ������������������������������������+0����������+0
 * ==================================================================
 */
function isFloat(objStr, sign, zero) {
	var reg;
	var bolzero;

	if (trim(objStr) == "")
		return false;
	else
		objStr = trim(objStr.toString());

	if ((sign == null) || (trim(sign) == ""))
		sign = "+-";

	if ((zero == null) || (trim(zero) == ""))
		bolzero = false;
	else {
		zero = zero.toString();
		bolzero = (zero == "true" || zero == "1");
	}

	switch (sign) {
		case "+-" :
			// ������
			reg = /^((-?|\+?)\d+)(\.\d+)?$/;
			break;
		case "+" :
			if (!bolzero) {
				// ��������
				reg = /^\+?(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$/;
			} else {
				// ��������+0
				reg = /^\+?\d+(\.\d+)?$/;
			}
			break;
		case "-" :
			if (!bolzero) {
				// ��������
				reg = /^-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$/;
			} else {
				// ��������+0
				reg = /^((-\d+(\.\d+)?)|(0+(\.0+)?))$/;
			}
			break;
		default :
			alert("�����Ų�����ֻ��Ϊ(�ա�+��-)");
			return false;
			break;
	}

	return (objStr.match(reg) != null);
}
/*
 * ==================================================================
 * ��srcStr�������뵽nAfterDotλС��
 * ==================================================================
 */
function FormatNumber(srcStr, nAfterDot) {
	var srcStr, nAfterDot;
	var resultStr, nTen;
	srcStr = "" + srcStr + "";
	strLen = srcStr.length;
	dotPos = srcStr.indexOf(".", 0);
	if (dotPos == -1) {
		resultStr = srcStr + ".";
		for (i = 0; i < nAfterDot; i++) {
			resultStr = resultStr + "0";
		}
	} else {
		if ((strLen - dotPos - 1) >= nAfterDot) {
			nAfter = dotPos + nAfterDot + 1;
			nTen = 1;
			for (j = 0; j < nAfterDot; j++) {
				nTen = nTen * 10;
			}
			resultStr = Math.round(parseFloat(srcStr) * nTen) / nTen;
		} else {
			resultStr = srcStr;
			for (i = 0; i < (nAfterDot - strLen + dotPos + 1); i++) {
				resultStr = resultStr + "0";
			}

		}
	}
	return resultStr;

}

/*
 * ================================================================== �ַ��������
 * ==================================================================
 */
function regInput(obj, reg, inputStr) {
	/**
	 * �������֣�/^[0-9]*$/ ��2λС����/^\d*\.?\d{0,2}$/ СдӢ�ģ�/^[a-z]*$/ ��дӢ�ģ�/^[A-Z]*$/ ��
	 * �ڣ�/^\d{1,4}([-\/](\d{1,2}([-\/](\d{1,2})?)?)?)?$/ �������ģ�input�� /^$/ paste
	 * or drop�� /^[\u4E00-\u9FA5]*$/
	 */
	var docSel = document.selection.createRange()

	if (docSel.parentElement().tagName != "INPUT")
		return false
	oSel = docSel.duplicate()
	oSel.text = ""

	var srcRange = obj.createTextRange()

	oSel.setEndPoint("StartToStart", srcRange)

	var str = oSel.text + inputStr + srcRange.text.substr(oSel.text.length)

	return reg.test(str)
}

/*
 * ==================================================================
 * ֻ������������ʹ��ʱ��form�м���ýű�����,�������븺��
 * ==================================================================
 */
function enableAllIntOnly(obj) {
	var reg = /^(-?)[0-9]*$/
	obj.onkeypress = function() {
		return regInput(this, reg, String.fromCharCode(event.keyCode))
	}
	obj.onpaste = function() {
		return regInput(this, reg, window.clipboardData.getData('Text'))
	}
	obj.ondrop = function() {
		return regInput(this, reg, event.dataTransfer.getData('Text'))
	}
}

/*
 * ==================================================================
 * ģ����ѯʱ,����������'����
 * ==================================================================
 */
function enableQuery(obj) {
	var reg = /^[^']+$/
	obj.onkeypress = function() {
		return regInput(this, reg, String.fromCharCode(event.keyCode))
	}
	obj.onpaste = function() {
		return regInput(this, reg, window.clipboardData.getData('Text'))
	}
	obj.ondrop = function() {
		return regInput(this, reg, event.dataTransfer.getData('Text'))
	}
}

/*
 * ==================================================================
 * ֻ������������ʹ��ʱ��form�м���ýű�����
 * ==================================================================
 */
function enableIntOnly(obj) {
	var reg = /^[0-9]*$/
	obj.onkeypress = function() {
		return regInput(this, reg, String.fromCharCode(event.keyCode))
	}
	obj.onpaste = function() {
		return regInput(this, reg, window.clipboardData.getData('Text'))
	}
	obj.ondrop = function() {
		return regInput(this, reg, event.dataTransfer.getData('Text'))
	}
}

function enableNumber2Only(obj) {
	obj.onkeypress = function() {
		return regInput(this, /^\d*\.?\d{0,2}$/, String
						.fromCharCode(event.keyCode))
	}
	obj.onpaste = function() {
		return regInput(this, /^\d*\.?\d{0,2}$/, window.clipboardData
						.getData('Text'))
	}
	obj.ondrop = function() {
		return regInput(this, /^\d*\.?\d{0,2}$/, event.dataTransfer
						.getData('Text'))
	}
}

function enableAllNumber2Only(obj) {
	obj.onkeypress = function() {
		return regInput(this, /^(-?)\d*\.?\d{0,2}$/, String
						.fromCharCode(event.keyCode))
	}
	obj.onpaste = function() {
		return regInput(this, /^(-?)\d*\.?\d{0,2}$/, window.clipboardData
						.getData('Text'))
	}
	obj.ondrop = function() {
		return regInput(this, /^(-?)\d*\.?\d{0,2}$/, event.dataTransfer
						.getData('Text'))
	}
}

function enableNumber4Only(obj) {
	obj.onkeypress = function() {
		return regInput(this, /^\d*\.?\d{0,4}$/, String
						.fromCharCode(event.keyCode))
	}
	obj.onpaste = function() {
		return regInput(this, /^\d*\.?\d{0,4}$/, window.clipboardData
						.getData('Text'))
	}
	obj.ondrop = function() {
		return regInput(this, /^\d*\.?\d{0,4}$/, event.dataTransfer
						.getData('Text'))
	}
}
/**
 * �������������ӷָ���,
 */
function enableIntWithSplit(obj) {
	var reg = /^[0-9,]*$/
	obj.onkeypress = function() {
		return regInput(this, reg, String.fromCharCode(event.keyCode))
	}
	obj.onpaste = function() {
		return regInput(this, reg, window.clipboardData.getData('Text'))
	}
	obj.ondrop = function() {
		return regInput(this, reg, event.dataTransfer.getData('Text'))
	}
}

/**
 * �������븡�����ӷָ���,
 */
function enableFloatWithSplit(obj, type) {
	if (type == null)
		reg = /^[0-9]*$/
	else if (type == 2)
		reg = /^[0-9,]*\.?\d{0,2}$/
	else if (type == 4)
		reg = /^[0-9,]*\.?\d{0,4}$/
	else if (type == 6)
		reg = /^[0-9,]*\.?\d{0,6}$/
	else
		return;
	obj.onkeypress = function() {
		if (event.keyCode != 13) {
			return regInput(this, reg, String.fromCharCode(event.keyCode))
		} else {
			if (typeof(textForward) != 'undefined') {
				textForward(obj);
			}
		}
	}
	obj.onpaste = function() {
		return regInput(this, reg, window.clipboardData.getData('Text'))
	}
	obj.ondrop = function() {
		return regInput(this, reg, event.dataTransfer.getData('Text'))
	}
}

/*
 * ==================================================================
 * ʹ��ʱ��form�м���ýű����ɣ�typeΪ��ʱ����ֻ���������� typeΪ2,4ʱ����ʾ2,4λС����Ϊ'a'��ʾСд��Ϊ'A'��ʾ��д��Ϊ
 * 'date'��ʾֻ����������
 * ==================================================================
 */
function enableOnly(obj, type) {
	var reg;
	if (type == null)
		reg = /^[0-9]*$/
	else if (type == 2)
		reg = /^\d*\.?\d{0,2}$/
	else if (type == 4)
		reg = /^\d*\.?\d{0,4}$/
	else if (type == 'a')
		reg = /^[a-z]*$/
	else if (type == 'A')
		reg = /^[A-Z]*$/
	else if (type == 'date')
		reg = /^\d{1,4}([-\/](\d{1,2}([-\/](\d{1,2})?)?)?)?$/
	else
		return;
	obj.onkeypress = function() {

		if (event.keyCode != 13) {
			return regInput(this, reg, String.fromCharCode(event.keyCode))
		} else {
			if (typeof(textForward) != 'undefined') {
				textForward(obj);
			}
		}
	}
	obj.onpaste = function() {
		return regInput(this, reg, window.clipboardData.getData('Text'))
	}
	obj.ondrop = function() {
		return regInput(this, reg, event.dataTransfer.getData('Text'))
	}
}

/**
 * �Ƚ�����ʱ��
 * @param {} d1
 * @param {} d2
 * @return {} ǰ�ߴ󷵻�1�����ߴ󷵻�-1����ͬ����0����ʱ�䷵��false
 */
function compareDate(d1, d2) {
	var reg = /^(\d{4})-(\d{1,2})-(\d{1,2})$/;
	if (reg.test(d1) && reg.test(d2)) {
		var day1 = d1.split("-"), day2 = d2.split("-"), date1 = new Date(), date2 = new Date();
		date1.setFullYear(parseInt(day1[0], 10), parseInt(day1[1], 10) - 1,
				parseInt(day1[2], 10));
		date2.setFullYear(parseInt(day2[0], 10), parseInt(day2[1], 10) - 1,
				parseInt(day2[2], 10));
		return date1 > date2 ? 1 : (date1 < date2 ? -1 : 0);
	} else {
		return NaN;
	}
}