#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<html>
<head>
  <script type="text/javascript" src="./js/jquery-1.5.1.min.js"><!--//--></script>
  <script type="text/javascript" src="./js/bristle.js"><!--//--></script>

  <script type="text/javascript">
    var config = {
      serverUrl: "ws://localhost:8080/websocket",
      OnOpen: function(event) {
        ${symbol_dollar}('${symbol_pound}status').text("The WebSocket Connection Is Open.");
      },
      OnClose: function(event) {
        ${symbol_dollar}('${symbol_pound}status').text("The WebSocket Connection Is Closed.");
      }
    };
    var client = Bristleback.newClient(config);
    var dataController = client.dataController;

    var sampleClientAction = {
      sayHello: function(helloText) {
        alert(helloText);
      }
    };

    function connect() {
      client.connect();
      Bristleback.Console.enableConsole();
    }

    function closeConnection() {
      client.disconnect("exit on demand");
    }

    /* ---------- CLIENT ACTIONS ---------- */

    dataController.registerClientActionClass("SampleClientAction", sampleClientAction);

    /* ---------- SERVER ACTIONS ---------- */

    var helloWorld = dataController.getActionClass("HelloWorld");

    helloWorld.defineDefaultAction()
      .setResponseHandler(reverseCallback)
      .exceptionHandler.setExceptionHandler("SerializationException", emptyInputCallback);

    helloWorld.defineAction("duplicateText")
      .setResponseHandler(duplicateCallback)
      .exceptionHandler.setExceptionHandler("SerializationException", emptyInputCallback);

    helloWorld.defineAction("sayHelloToAll");

    function reverse() {
      var text = document.getElementById("textInput").value;
      helloWorld.executeDefault(Bristleback.CONNECTOR, text);
    }

    function reverseCallback(reversedValue) {
      ${symbol_dollar}('${symbol_pound}status').text("Reversed value: " + reversedValue);
    }

    function duplicate() {
      var text = document.getElementById("textInput").value;
      helloWorld.duplicateText(text);
    }

    function sayHelloToAll() {
      helloWorld.sayHelloToAll();
    }

    function duplicateCallback(duplicatedValue) {
      ${symbol_dollar}('${symbol_pound}status').text("Duplicated value: " + duplicatedValue);
    }

    function emptyInputCallback() {
      ${symbol_dollar}('${symbol_pound}status').text("This is an exception callback for SerializationException!");
    }


  </script>

  <style type="text/css">
    * {
      font-size: 14px;
      font-family: arial, sans-serif;
    }

    div {
      padding-bottom: 10px;
    }
  </style>

</head>

<body>
<div id="status">Disconnected. Click connect button to start playing.</div>
<div>
  <input type="button" onclick="connect()" value="Connect">
  <input type="button" onclick="closeConnection()" value="Close connection">
</div>

<div>
  <input type="text" name="textInput" id="textInput"/>
  <input type="button" onclick="reverse()" value="Reverse text!"/>
  <input type="button" onclick="duplicate()" value="Duplicate text!"/>
  <input type="button" onclick="sayHelloToAll()" value="Say Hello to all"/>
</div>

</body>
</html>
