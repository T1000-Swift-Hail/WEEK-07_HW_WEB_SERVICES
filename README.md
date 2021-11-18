# WEEK-07_HW_WEB_SERVICES

## Using what you learned in web services ( URLSession ) , create an app that will display a random Pet image each time you click on the button.

### Your applicaiton should use :
- URLSession
- the url for the api : https://dog.ceo/api/breeds/image/random

#### Sample response from the above api link:
    {"message":"https:\/\/images.dog.ceo\/breeds\/terrier-lakeland\/n02095570_199.jpg","status":"success"}  
note : the url link for the iimage is in the message key .


### When a user clicks on the "Show New" , your application should fetch the json data from the above link and display the image in the view .

### Your application should look similar to this app:

<div style="text-align:center; width: 100%; display: flext; flex-direction: row; flex-wrap: wrap;">
   <img src = "" style="width:45%; height: auto"/>
   <img src = "" style="width:45%; height: auto"/>
 
 <br/>

</div>
