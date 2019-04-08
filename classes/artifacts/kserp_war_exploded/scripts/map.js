/* 
* Map对象，实现Map功能 
* 
* 
* size() 获取Map元素个数 
* isEmpty() 判断Map是否为空 
* clear() 删除Map所有元素 
* put(key, value) 向Map中增加元素（key, value)  
* remove(key) 删除指定key的元素，成功返回true，失败返回false 
* get(key) 获取指定key的元素值value，失败返回null 
* element(index) 获取指定索引的元素（使用element.key，element.value获取key和value），失败返回null 
* containsKey(key) 判断Map中是否含有指定key的元素 
* containsValue(value) 判断Map中是否含有指定value的元素 
* keys() 获取Map中所有key的数组（array） 
* values() 获取Map中所有value的数组（array） 
* 
*/ 
function Map(){ 
this.elements = new Array(); 
  
//获取Map元素个数 
this.size = function() { 
  return this.elements.length; 
}, 

//判断Map是否为空 
this.isEmpty = function() { 
return (this.elements.length < 1); 
}, 

//删除Map所有元素 
this.clear = function() { 
this.elements = new Array(); 
}, 

//向Map中增加元素（key, value)  
this.put = function(_key, _value) { 
if (this.containsKey(_key) == true) { 
if(this.containsValue(_value)){ 
if(this.remove(_key) == true){ 
this.elements.push( { 
key : _key, 
value : _value 
}); 
} 
}else{ 
this.elements.push( { 
key : _key, 
value : _value 
}); 
} 
} else { 
this.elements.push( { 
key : _key, 
value : _value 
}); 
} 
}, 

//删除指定key的元素，成功返回true，失败返回false 
this.remove = function(_key) { 
var bln = false; 
try {   
for (i = 0; i < this.elements.length; i++) {   
if (this.elements[i].key == _key){ 
this.elements.splice(i, 1); 
return true; 
} 
} 
}catch(e){ 
bln = false;   
} 
return bln; 
}, 

//获取指定key的元素值value，失败返回null 
this.get = function(_key) { 
try{   
for (i = 0; i < this.elements.length; i++) { 
if (this.elements[i].key == _key) { 
return this.elements[i].value; 
} 
} 
}catch(e) { 
return null;   
} 
}, 

//获取指定索引的元素（使用element.key，element.value获取key和value），失败返回null 
this.element = function(_index) { 
if (_index < 0 || _index >= this.elements.length){ 
return null; 
} 
return this.elements[_index]; 
}, 

//判断Map中是否含有指定key的元素 
this.containsKey = function(_key) { 
var bln = false; 
try { 
for (i = 0; i < this.elements.length; i++) {   
if (this.elements[i].key == _key){ 
bln = true; 
} 
} 
}catch(e) { 
bln = false;   
} 
return bln; 
}, 
    
//判断Map中是否含有指定value的元素 
this.containsValue = function(_value) { 
var bln = false; 
try { 
for (i = 0; i < this.elements.length; i++) {   
if (this.elements[i].value == _value){ 
bln = true; 
} 
} 
}catch(e) { 
bln = false;   
} 
return bln; 
}, 
  
//获取Map中所有key的数组（array） 
this.keys = function() { 
var arr = new Array(); 
for (i = 0; i < this.elements.length; i++) {   
arr.push(this.elements[i].key); 
} 
return arr; 
}, 

//获取Map中所有value的数组（array） 
this.values = function() { 
var arr = new Array(); 
for (i = 0; i < this.elements.length; i++) {   
arr.push(this.elements[i].value); 
} 
return arr; 
}; 

} 


/**
* 判断提供的字符串是否为空
* @param field 输入字符串
* @return true/false
*/
function isEmpty(field)
{
	return ((field == null) || (field.length == 0) || myTrim(field)=="");
}
	
/**
 * 去掉输入字符串的前后空格
 * @param str 输入字符
 * @return  去掉前后空格的字符串
 */
function myTrim(str)
{
	var end = false;
	var ch;

	while(!end)
	{
		if (str.length == 0) break;
		ch = str.charAt(0);

		if (ch == ' ')
		{
			str = str.substring(1,str.length);
		}
		else
		{
			end = true;
		}
	}

	end = false;

	while(!end)
	{
		if (str.length == 0)
		{
			break;
		}

		ch = str.charAt(str.length-1);

		if (ch == ' ')
		{
			str = str.substring(0,str.length-1);
		}
		else
		{
			end = true;
		}
	}

	return str;
}

/**
 * 判断是否是数字
 * @param str 输入字符
 * @return  true/false
 */
function isNumbers(field)
{
	field = myTrim(field);

	var i;

	for (i = 0; i < field.length; i++)
	{
		var c = field.charAt(i);

		if (!isDigit(c) )
		{
			return false;
		}
	}

	return true;
}

function isDigit(c)
{
	return ((c >= "0") && (c <= "9") || c==".");
}

/**
 * 判断是否是数字
 * @param str 输入字符
 * @return  true/false
 */
function isNumbersBfb(field)
{
	field = myTrim(field);

	var i;

	for (i = 0; i < field.length; i++)
	{
		var c = field.charAt(i);

		if (!isDigitBfb(c) )
		{
			return false;
		}
	}

	return true;
}

function isDigitBfb(c)
{
	return ((c >= "0") && (c <= "9") || c=="." || c=="%");
}

/**
 * 判断是否是数字与百分比
 * @param str 输入字符
 * @return  true/false
 */
function isNumbersOrBi(field)
{
	field = myTrim(field);

	var i;

	for (i = 0; i < field.length; i++)
	{
		var c = field.charAt(i);

		if (!isDigitOrBi(c) )
		{
			return false;
		}
	}

	return true;
}

function isDigitOrBi(c)
{
	return ((c >= "0") && (c <= "9") || c=="%" || c==".");
}

/**
 * 判断是否有特殊字符
 * @param str 输入字符
 * @return  true/false
 */
function isValidate(field)
{
	var i;

	for (i = 0; i < field.length; i++)
	{
		var c = field.substr(i,1);

		if (! (isLetter(c) || isDigit(c) ) )
		{
			return false;
		}
	}

	return true;
}

/**
 * 判断是否是字母
 * @param str 输入字符
 * @return  true/false
 */
function isLetter(c)
{
	return ( ((c >= "a") && (c <= "z")) || ((c >= "A") && (c <= "Z")) );
}

var rangeMsg='您输入的日期超出范围!';
var formatMsg='您输入的日期必须是[年-月-日]格式!'
/**
 * 判断日期格式
 * @param str 输入字符
 * @return  true/false
 */
function isDate(value) {
			
	if(value == null || value == ""){
	return EMPTools.message(true, "");//如果未输入任何数据，则不作格式检查和转换。
	}
			
	var idx = value.indexOf("-");
	if(idx != -1){
		var _arr = value.split('-');
		var year = _arr[0];
		var month = _arr[1];
		var date = _arr[2];
		if((year!=null||year!="")&&year.length>4){
			return alert("输入的年份不正确，请重新输入！");
		}
		if((month!=null||month!="")&&month.length>2){
			return alert("输入的月份不正确，请重新输入！");
		}
		if((date!=null||date!="")&&date.length>2){
			return alert("输入的日期不正确，请重新输入！");
		}
	}else{
		if(value.length != 8){
			return alert(formatMsg);
		}
		var year = value.substring(0,4);
		var month = value.substring(4,6);
		var date = value.substring(6,8);
	}
			
	//月份是从0-11，因此new Date时需要将月份减1
	var dateObj = new Date(year,month-1,date);
	if(isNaN(dateObj)){
		return alert(formatMsg);
	}
			
	year = "" + dateObj.getFullYear();
	month = "" + (dateObj.getMonth()+1);
	if(month.length == 1)
		month = "0" + month;
		date = "" + dateObj.getDate();
		if(date.length == 1)
			date = "0" + date;
			
	var value = year + "-" + month + "-" + date;
			
	return EMPTools.message(true, value);
}

/**
 * 判断日期格式
 * @param str 输入字符
 * @return  true/false
 */
function isDateYes(value) {
			
	if(value == null || value == ""){
		//return EMPTools.message(true, "");//如果未输入任何数据，则不作格式检查和转换。
	}
			
	var idx = value.indexOf("-");
	if(idx != -1){
		var _arr = value.split('-');
		var year = _arr[0];
		var month = _arr[1];
		var date = _arr[2];
		if((year!=null||year!="")&&year.length>4){
			return false;
		}
		if((month!=null||month!="")&&month.length>2){
			return false;
		}
		if((date!=null||date!="")&&date.length>2){
			return false;
		}
	}else{
		if(value.length != 8){
			return false1;
		}
		var year = value.substring(0,4);
		var month = value.substring(4,6);
		var date = value.substring(6,8);
	}
			
	//月份是从0-11，因此new Date时需要将月份减1
	var dateObj = new Date(year,month-1,date);
	if(isNaN(dateObj)){
		return false;
	}
			
	year = "" + dateObj.getFullYear();
	month = "" + (dateObj.getMonth()+1);
	if(month.length == 1)
		month = "0" + month;
		date = "" + dateObj.getDate();
		if(date.length == 1)
			date = "0" + date;
			
	var value = year + "-" + month + "-" + date;
			
	return true;
}

/**
 * 检查用户输入的字符串是否含有非法字符" , & , < , > ,^ , @ , ' , "", \, ;, ^, $
 * @pram field 被检测的字符串
 * @return true/false
 */
function containInvalidChar(field)
{
	if(field.match(/^\_+$/g))
	{
		return true;
	}
	
	for (i = 0; i < field.length; i++)
	{
		var c = field.charAt(i);

		if(c == '_' || c == '&' || c == '<'
		   || c == '>' || c == '"'
		   || c == '@' || c == '#'|| c == '\\'|| c == '`'
		   || c == '$' || c == '^' || c == '\/' || c == '~' || c == '%'|| c == '*')
		{
			return true;
		}
	}

	return false;
}

function inputNumber(oElement, length, decimal)
{
	var oInput = oElement;
	var oInputValue = trim(oInput.value);
	//alert(oInputValue);
	var iLowcase = oInputValue.indexOf("e");
	var iUpcase = oInputValue.indexOf("E");

	if( oInputValue == "")							//为空值
	{
		oInput.value = "";
		return true;
	}

	if (existChinese(oInputValue))					//包含汉字
	{
		alert("含有非法字符，请输入正确的百分比！");
		//oInput.value = "";
		return true;
	}
	
	if (!isNumbersOrBi(oInputValue))					//非数字，"%"，"."
	{
		alert("含有非法字符，请输入正确的百分比！");
		//oInput.value = "";
		return true;
	}
	
	if((iLowcase != -1)||(iUpcase != -1))			//科学记数法
	{
		/***********************************************
				处理科学记数法
		***********************************************/
		return true;
	}

	//一般记数法
	var bOverflow = false;							//是否溢出
	var partInteger = "";							//整数部分的值
	var countIntegerLength = 0;						//整数部分长度
	var partDecimal = "";							//小数部分的值
	var countDecimalLength = 0;						//小数部分长度

	var iPoint = oInputValue.indexOf(".");			//小数点位置

	var allowIntegerLength = length - decimal - 1;	//整数部分允许长度
	var allowDecimalLength = decimal;				//小数部分允许长度

	//获得输入数据的整数部分和小数部分
	if(iPoint == -1)		//输入是整数
	{
		var iInput = oInputValue.split("%");
		if(iInput.length>0)
		{	
			partInteger = iInput[0];
		}
		else{
			partInteger = oInputValue;
		}
		partInteger = trimZero(partInteger);		//去除前导0
		countIntegerLength = oInputValue.length;
	}
	else					//输入是小数
	{
		partInteger = oInputValue.substring(0,iPoint);
		if (!isNumbers(partInteger))					//非数字，"%"，"."
		{
			alert("含有非法字符，请输入正确的百分比！");
			//oInput.value = "";
			return true;
		}
	
		partInteger = trimZero(partInteger);		//去除前导0
		countIntegerLength = partInteger.length;
		//直接用去尾法截取小数位
		partDecimal = oInputValue.substring(iPoint + 1, iPoint + 1 + allowDecimalLength);
		countDecimalLength = partDecimal.length;
	}
	if (partInteger == "")	//去除前导0后为空
	{
		partInteger = "0";
	}

	//判断整数部分的位数是否超过允许的位数，若是则溢出为0
	if(countIntegerLength > allowIntegerLength)
	{
		partInteger = "0";
		bOverflow = true;
	}

	//将不足小数部分补零
	if(countDecimalLength < allowDecimalLength)
	{
		for (var iDecimal = 0; iDecimal < (allowDecimalLength - countDecimalLength); iDecimal++)
			partDecimal = partDecimal + "0";
	}

	//将整数部分和小数部分组合
	if (partDecimal != "")
	{
		oInput.value = partInteger + "." + partDecimal+"%";
	}
	else
	{
		oInput.value = partInteger;
	}
	if (bOverflow) oInput.focus();	
	
}

/************************************************************************************
名称：	formatInputNumber(oElement, length, decimal)
功能：	该函数用于格式化输入框（INPUT）的值,只用于非负数的情况
参数：	oElement---入参；对象；待处理的输入框（INPUT）对象
		length-----入参；数字；数值长度(包括小数点)
		decimal----入参；数字；小数位数
返回：	数值型
引用：	trim(strValue);trimZero(strValue);existChinese(strValue);
说明：	如果输入数据包含汉字，则返回空值
		如果输入数据大于规定的位数，则溢出为0，并格式化成相应的小数位数
		如果输入数据的小数位数大于要求的位数，则用去尾法消去，若不足要求的小数位数则补零
		小数点占一位
		一般用于INPUT对象的ONBLUR事件
Author:	hejunxiang
**************************************************************************************/

function formatInputNumber(oElement, length, decimal)
{
	var oInput = oElement;
	var oInputValue = trim(oInput.value);
	//alert(oInputValue);
	var iLowcase = oInputValue.indexOf("e");
	var iUpcase = oInputValue.indexOf("E");

	if( oInputValue == "")							//为空值
	{
		oInput.value = "";
		return true;
	}

	if (existChinese(oInputValue))					//包含汉字
	{
		alert("含有非法字符，请输入百分比！");
		oInput.value = "";
		return true;
	}
	
	if (!isNumbersOrBi(oInputValue))					//非数字，"%"，"."
	{
		alert("含有非法字符，请输入百分比！");
		oInput.value = "";
		return true;
	}
	
	if((iLowcase != -1)||(iUpcase != -1))			//科学记数法
	{
		/***********************************************
				处理科学记数法
		***********************************************/
		return true;
	}

	//一般记数法
	var bOverflow = false;							//是否溢出
	var partInteger = "";							//整数部分的值
	var countIntegerLength = 0;						//整数部分长度
	var partDecimal = "";							//小数部分的值
	var countDecimalLength = 0;						//小数部分长度

	var iPoint = oInputValue.indexOf(".");			//小数点位置

	var allowIntegerLength = length - decimal - 1;	//整数部分允许长度
	var allowDecimalLength = decimal;				//小数部分允许长度

	//获得输入数据的整数部分和小数部分
	if(iPoint == -1)		//输入是整数
	{
		partInteger = oInputValue;
		partInteger = trimZero(partInteger);		//去除前导0
		countIntegerLength = oInputValue.length;
	}
	else					//输入是小数
	{
		partInteger = oInputValue.substring(0,iPoint);
		partInteger = trimZero(partInteger);		//去除前导0
		countIntegerLength = partInteger.length;
		//直接用去尾法截取小数位
		partDecimal = oInputValue.substring(iPoint + 1, iPoint + 1 + allowDecimalLength);
		countDecimalLength = partDecimal.length;
	}
	if (partInteger == "")	//去除前导0后为空
	{
		partInteger = "0";
	}

	//判断整数部分的位数是否超过允许的位数，若是则溢出为0
	if(countIntegerLength > allowIntegerLength)
	{
		partInteger = "0";
		bOverflow = true;
	}

	//将不足小数部分补零
	if(countDecimalLength < allowDecimalLength)
	{
		for (var iDecimal = 0; iDecimal < (allowDecimalLength - countDecimalLength); iDecimal++)
			partDecimal = partDecimal + "0";
	}

	//将整数部分和小数部分组合
	if (partDecimal != "")
	{
		oInput.value = partInteger + "." + partDecimal+"%";
	}
	else
	{
		oInput.value = partInteger;
	}
	if (bOverflow) oInput.focus();
}

/************************************************************************************
名称：	trim(strValue)
功能：	该函数用于去除字符串前后的空格
参数：	strValue---入参；字符串；待处理的字符串
返回：	字符串
引用：	无
说明：	若为全空格字符串则返回空
**************************************************************************************/
function trim(strValue)
{
	var iLTR, jRTL;
	var chr;

	//去除字符串前后的空格
	for( iLTR = 0; iLTR < strValue.length; iLTR++ )
	{
		chr = strValue.charAt(iLTR) ;
		if( chr != " " ) break;
	}

	if( iLTR == strValue.length ) return "";

	//去除字符串前后的空格
	for( jRTL = strValue.length - 1; jRTL >= 0; jRTL-- )
	{
		chr = strValue.charAt(jRTL);
		if( chr != " " ) break;
	}
	return strValue.substring(iLTR, jRTL + 1);
}

/************************************************************************************
名称：	trimZero(strValue)
功能：	该函数用于去除字符串的前导0
参数：	strValue---入参；字符串；待处理的字符串
返回：	字符串
引用：	无
说明：	若为全0字符串则返回空
**************************************************************************************/
function trimZero(strValue)
{
	var iLTR;
	var chr;

	//去除字符串前导0
	for( iLTR = 0; iLTR < strValue.length; iLTR++ )
	{
		chr = strValue.charAt(iLTR) ;
		if( chr != "0" ) break;
	}

	if( iLTR == strValue.length ) return "";

	return strValue.substring(iLTR, strValue.length);
}

/************************************************************************************
名称：	existChinese(strValue)
功能：	该函数用于检查字符串是否包含汉字
参数：	strValue---入参；字符串；待处理的字符串
返回：	布尔值； true--包含汉字； false--不包含汉字
引用：	无
说明：
**************************************************************************************/
function existChinese(strValue)
{
	var chrCode
	for(var iChar = 0; iChar < strValue.length; iChar++)
	{
		chrCode = strValue.charCodeAt(iChar);
		if(parseInt(chrCode) > 255)
		{
			return true;
		}
	}
	return false;
}