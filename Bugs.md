* Cannot properly decode JSON from server.  There seem to be two issues:
    1) the data type for decoding Messages in the model isn't quite right
    2) the decoding of the JSON is also a wrong data type.
This issue was fixed by making them both into dictionaries and reading their values.

* A URLSession in the controller would not return any values
This was fixed by adding .resume() to the end of the session

* I'm not sure if it was a bug, but I didn't like that the URL was a static let.
Changed the baseURL to a let

* The Detail View Controller would not display information from the Detail Table View Controller
There was a typo in the segue identifier.  Fixed it.

* The Detail VC would not pop from the stack
Added code to pop Detail VC from the stack when the new message was saved

* A new message could be saved with blank text field values
Changed code to mandate text in the senderName and messageText elements.
