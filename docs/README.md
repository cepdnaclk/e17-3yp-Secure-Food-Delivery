---
layout: home
permalink: index.html

# Please update this with your repository name and project title
repository-name: e17-3yp-Secure-Food-Delivery
title: Secure Food Delivery
---

[comment]: # "This is the standard layout for the project, but you can clean this and use your own template"

# Secure Food Delivery

---

## Team
-  E/17/240, Pathum T.N.D., [e17240@eng.pdn.ac.lk](mailto:e17240@eng.pdn.ac.lk)
-  E/17/405, Wijesinghe W.D.L.P., [e17405@eng.pdn.ac.lk](mailto:e17405@eng.pdn.ac.lk)
-  E/17/083, Ekanayake E.M.M.U.B., [e17083@eng.pdn.ac.lk](mailto:e17083@eng.pdn.ac.lk)


<!-- Image (photo/drawing of the final hardware) should be here -->

<!-- This is a sample image, to show how to add images to your page. To learn more options, please refer [this](https://projects.ce.pdn.ac.lk/docs/faq/how-to-add-an-image/) -->

<!-- ![Sample Image](./images/sample.png) -->

#### Table of Contents
1. [Introduction](#introduction)
2. [Solution Architecture](#solution-architecture )
3. [Control and Dataflow](#control-and-dataflow)
4. [Hardware & Software Designs](#hardware-and-software-designs)
5. [Testing](#testing)
6. [Estimated budget](#estimated-budget)
7. [Estimated Timeline](#estimated-timeline)
8. [Conclusion](#conclusion)
9. [Links](#links)

## Introduction
As we are really busy with our day-to-day life, almost everyone is like to have their meal wherever and whenever they want. So, online food delivery services are really famous and very popular among people. There are so many food delivery services in Sri Lanka and there are huge beneficiaries also. We are providing some extra service for those delivery services such that they can improve their security issues which must be solved before it becomes a disadvantage for such great service.

## Current Problem
There are services which are providing online food delivery service already but, there are some serious issues regarding those services. The main thing is about security (Reliability/Trust). In this particular situation those questions 'How much we can trust those services? as customers' and 'How much we can trust those services? as restaurant owners' can be occurred. There are two major roles in here. First one is the restaurant owners who provide food through delivery services and the second one is the customer who orders food through delivery service (Website or Mobile App). We saw some complaints and some news about 'not delivering the ordered food accordingly' and also complaints about 'not having food with great quality' from customers. Also, we could see that restaurant owners could not do anything about that as delivery service provides the service of delivery. But they have the issue about their customer's trust. This becomes a problem in a good service and we want to give a solution that would help to develop the online food delivery service.

## Solution
As it becomes a real-world problem, we thought about having a solution. Basically, we provide a locking system for the food container which can only be accessible from two ends. The person from restaurant side providing food can unlock the container using a RFID card and put the order into it. After locking the container, it can only be unlocked by the customer using an OTP or a RFID card or both. That must satisfy customers as it cannot be opened within delivery. So, they can trust about whatever they buy.

## Solution Architecture

High level diagram + description
<html><body><div>
    <div class="inline-block">
        <img src ="https://github.com/LahiruPathum0141/e17-3yp-Secure-Food-Delivery/blob/main/docs/images/SolutionArchitecture.png" align="center">
    </div>
</div></body></html>

## Control and Dataflow

<div>
    <div class="inline-block">
        <img src ="https://github.com/LahiruPathum0141/e17-3yp-Secure-Food-Delivery/blob/main/docs/images/ControlAndDataflow.png" align="center">
    </div>
</div>

## Hardware and Software Designs

Detailed designs with many sub-sections

## Testing

Testing done on hardware and software, detailed + summarized results



## Estimated Budget

All items and costs

| Item                        | Quantity  | Unit Cost  | Total  |
| --------------------------- |:---------:|:----------:|-------:|
| TTGO T-Call ESP32 SIM800L   | 1         | 3200       | 3200   |
| RFID RC522                  | 1         |  600       |  600   |
| 12V DC Solenoid Lock        | 1         | 1000       | 1000   |
| LCD 2004 Display            | 1         |  850       |  850   |
| 3.7V Li-ion battery 3300mAh | 3         |  550       | 1650   |
| Breadboard                  | 1         |  400       |  400   |
| Single Channel 5V relay     | 1         |  550       |  550   |
| I2C Serial interface Module | 1         |  200       |  200   |
| DC-DC Boost Converter       | 1         |  150       |  150   |
| DC-DC Buck Converter        | 2         |  200       |  400   |
| Other items                 | -         |  -         | 1000   |
| Total                       |           |            | 10000  |


## Estimated Timeline

<div>
    <div class="inline-block">
        <img src ="https://github.com/LahiruPathum0141/e17-3yp-Secure-Food-Delivery/blob/main/docs/images/timeline.jpg" align="center">
    </div>
</div>

## Conclusion

What was achieved, future developments, commercialization plans

## Links

- [Project Repository](https://github.com/cepdnaclk/e17-3yp-Secure-Food-Delivery)
- [Project Page](https://cepdnaclk.github.io/e17-3yp-Secure-Food-Delivery/)
- [Department of Computer Engineering](http://www.ce.pdn.ac.lk/)
- [University of Peradeniya](https://eng.pdn.ac.lk/)

[//]: # (Please refer this to learn more about Markdown syntax)
[//]: # (https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
