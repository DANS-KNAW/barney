<html>
<head>
	<script>
		function showPage(page){

				document.getElementById('page1').style.display = 'block';
				document.getElementById('page2').style.display = 'none';

		}

		function getHttpRequest(){
			var http;
			if (window.ActiveXObject){
			    http = new ActiveXObject("Microsoft.XMLHTTP");
			}
			else if (window.XMLHttpRequest){
			    http = new XMLHttpRequest();
			}
			return http;
		}

		function getSelectedItem(selectBox){
			var box = document.getElementById(selectBox);
			var item = '';
			for(var i=0;i<box.options.length;i++){
				if(box.options[i].selected == true){
					item = box.options[i].value;
				}
			}
			return item;
		}

		function sendRequest() 
		{
			var uri = document.getElementById('uri').value;
			var xml = document.getElementById('xml').value;
			var method = getSelectedItem('method');
			var http = getHttpRequest();
			http.onreadystatechange = function() 
			{
				if(http.readyState==4)
				{
					try 
					{
						var div = document.getElementById("page2");
						
						var text = '<TEXTAREA NAME="naam" ROWS="13" COLS="100">'+http.responseText+'</TEXTAREA>';	
						div.innerHTML = text;								
					} 
					catch(e) 
					{
						alert(e);
					}
				}
			}
			try 
			{
				http.open(method, uri);
				http.setRequestHeader('Content-Type', 'text/xml');
				http.send('xml=' + xml);			
				} catch(e) {
				alert(e);
			}
		}
	</script>
</head>
<body>

<div id="page1" style="position:absolute; top:60px; width:800px; height:600px;display:none; border: 1px solid #000000;">

</div>

<div id="page2" style="position:absolute; top:60px; width:800px; height:600px; border: 1px solid #000000;">
	<table>
		<tr>
			<td>
				<strong>Method</strong>
			</td>
			<td>
				<select id="method">
					<option value="POST">POST</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<strong>URI</strong>
			</td>
			<td>
				<input style="width:700px;" type="text" id="uri" value="http://localhost:8080/barney/restlet/domain/1/user/31/policy"></input>
			</td>
		</tr>
		<table>
			<tr><td>
				<strong>xml</strong>
			</td></tr>
			<tr><td>
				<textarea style="width:700px;height:400px;overflow:auto;" name="xml" id="xml" 
				value="
				<permissions>
        			<rule group="1" read="true" write="false" execute="true" />
		        	<rule group="2" read="true" write="false" execute="true" />
        			<rule group="3" read="true" write="true" execute="false" />
				</permissions>
				" ></textarea>
			</td></tr>
		</table>

		<tr>
		
			<td style="float:right;">
				<input type="button" onClick="sendRequest()" value="Send request"/>
			</td>
		</tr>
	</table>
	<br><br><br><a href=index.html><b>Back..</b></a>
</div>
</body>
</html>