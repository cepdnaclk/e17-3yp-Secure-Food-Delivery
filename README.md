___
# Secure Food Delivery
___

[**Here is our website!!**](https://cepdnaclk.github.io/e17-3yp-Secure-Food-Delivery/)

# Introduction

As we are really busy with our day to day life, almost everyone is like to have their meal wherever and whenever they want. So, online food delivery services are really famous and very popular among people. There are so many food delivery services in Sri Lanka and there are huge beneficiaries also. We are providing some extra service for those delivery services such that they can improve their security issues which must be solved before it becomes a disadvantage for such great service.

# Current Problem 
There are services which are providing online food delivery service already but, there are some serious issues regarding those services. The main thing is about security (Reliability/Trust). In this particular situation those questions 'How much we can trust those services? as customers' and 'How much we can trust those services? as restaurant owners' can be occured. There are two major roles in here. First one is the restaurant owners who provide food through delivery services and the second one is the customer who orders food through delivery service (Website or Mobile App). 
We saw some complaints and some news about 'not delivering the ordered food accordingly' and also complaints about 'not having food with great quality' from customers. Also we could see that restaurant owners could not do anything about that as delivery service provides the service of delivery. But they have the issue about their customer's trust. This becomes a problem in a good service and we want to give a solution that would help to develop the online food delivery service.

# Solution
As it becomes an real world problem, we thought about having a solution. Basically, we provide a locking system for the food container which can only be accessible from two ends. The person from restaurent side providing food can unlock the container using a RFID card and put the order into it. After locking the container, it can only be unlocked by the customer using an OTP or a RFID card or both. That must satisfy customers as it cannot be opened within delivery. So, they can trust about whatever they buy. 

### Enable GitHub Pages

You can put the things to be shown in GitHub pages into the _docs/_ folder. Both html and md file formats are supported. You need to go to settings and enable GitHub pages and select _main_ branch and _docs_ folder from the dropdowns, as shown in the below image.

![image](https://user-images.githubusercontent.com/11540782/98789936-028d3600-2429-11eb-84be-aaba665fdc75.png)

### Special Configurations

These projects will be automatically added into [https://projects.ce.pdn.ac.lk](). If you like to show more details about your project on this site, you can fill the parameters in the file, _/docs/index.json_

```
{
  "title": "This is the title of the project",
  "team": [
    {
      "name": "Team Member Name 1",
      "email": "email@eng.pdn.ac.lk",
      "eNumber": "E/yy/xxx"
    },
    {
      "name": "Team Member Name 2",
      "email": "email@eng.pdn.ac.lk",
      "eNumber": "E/yy/xxx"
    },
    {
      "name": "Team Member Name 3",
      "email": "email@eng.pdn.ac.lk",
      "eNumber": "E/yy/xxx"
    }
  ],
  "supervisors": [
    {
      "name": "Dr. Supervisor 1",
      "email": "email@eng.pdn.ac.lk"
    },
    {
      "name": "Supervisor 2",
      "email": "email@eng.pdn.ac.lk"
    }
  ],
  "tags": ["Web", "Embedded Systems"]
}
```

Once you filled this _index.json_ file, please verify the syntax is correct. (You can use [this](https://jsonlint.com/) tool).

### Page Theme

A custom theme integrated with this GitHub Page, which is based on [github.com/cepdnaclk/eYY-project-theme](https://github.com/cepdnaclk/eYY-project-theme). If you like to remove this default theme, you can remove the file, _docs/\_config.yml_ and use HTML based website.
