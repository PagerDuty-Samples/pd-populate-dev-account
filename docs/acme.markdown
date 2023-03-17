---
layout: page
title: ACME Inc Needs PagerDuty
permalink: /acme/
navigation_weight: 2
---
![ACME Logo](/img/acme-mark.png){: style="float: left"}
*At Acme Inc, our mission is to provide high-quality widgets that meet the needs of our customers while maintaining the highest levels of customer service and satisfaction. We strive to be a leader in the industry by continuously improving our products, processes, and customer experiences.*

{:style="clear: both"}

## People and Teams
Acme is modernizing their IT infrastructure and response workflows. They've purchased a PagerDuty account to help their teams manage incidents and response. Their first phase is to deploy PagerDuty for two teams: the Helpdesk and the IT Operations team.

- The **Helpdesk** includes two teams, located in two offices. The teams are assigned to their service desk in shifts, but they will also have on call duties for high-severity issues and holiday coverage. The Helpdesk will be using PagerDuty to ensure that no important customer or user issues are missed and to provide some transparency to the executive team about the number of issues and how they are being handled.
  - Each team is made up of 6 helpdesk engineers
  - The teams have 12-hour rotations, and each engineer is on call one day every 6


- The **IT Operations** team is one large team with several areas of responsibility. Engineers have a specialization and share on-call responsibilities with a sub-team that is all trained on the applicable platforms. IT Operations will be adopting PagerDuty after a series of service outages impacted crucial business operations and a large customer deal.
  - There are 16 people on IT Operations.
  - They are divided into four teams based on the services they support.
  - The IT Operations team is new to having 24-hour on call responsibilities. The executive team is hoping to improve the reliability of IT systems going forward.

Because of recent instability in the IT systems, the executive team is invested in improving the performance of the systems and the team. The executive team includes the CEO, the Head of Global Sales, and the Manufacturing Foreman. 
- The *CEO* wants to know about ALL IT issues. Recent system failures have been very bad for the company’s PR.
- The *Head of Global Sales* wants to know when the CRM application is having issues. Recent issues have included outages on the CRM system and have impacted sales and customer relationships. The Head of Global Sales is interested in knowing only that an incident is happening, so the rest of the sales team in the field can be notified.
- The *Manufacturing Foreman* needs to know about issues with the CRM and mainframe systems. The mainframe is connected to the automation systems that manage the equipment on the manufacturing floor, and any issues can cause a halt in production.

## Schedules
The teams at ACME, Inc, have different requirements for their on-call schedules, so their models will be different.

### Helpdesk
The ACME Helpdesk team has one shared set of responsibilities for the whole team. Everyone on the team is able to perform any of the tasks that are assigned to them through the Helpdesk queue.

The two teams will use a follow-the-sun model made up of two 12-hour shifts. The teams work staggered shifts in the office so there is always live coverage.  Each shift will have one Helpdesk engineer as the “on call” for priority work and to respond to emergencies during holidays. There are usually few emergencies on the weekends when the office and manufacturing plant are closed, but the CEO has asked the Helpdesk to cover weekends as well while the reliability of all the systems is being improved.

### The IT Operations Team 
ACME IT Operations has a total team of 16 engineers divided into several teams based on the services they support. The division of labor helps each team concentrate on the services they need to know the best, but has caused confusion during prior incidents when other teams weren’t sure who to contact about problems. Due to this confusion, most of the team has been cross-trained on all the systems. ACME leadership is concerned that the lack of specialization and deep understanding of the company’s systems has contributed to the reduced reliability of key components.

The IT team will receive escalated tickets from the Helpdesk if issues are reported that way, or other employees at ACME will raise an issue with IT Operations directly if they happen to know who is currently responsible for the service they have an issue with. 

The IT Operations team will follow a 24x7 schedule and have a weekly on call rotation. Due to the division of labor across IT, there will be four schedules to accommodate the four system concentrations.

IT Operations supports four major business-systems areas:

- Core Services
  - This includes centralized IT services like Active Directory, DNS, DHCP, the VPN, and the network connectivity to the manufacturing facility
  - They use VMware as a hypervisor 
  - Core Services is also responsible for the databases that support the CRM system
- Web Applications
  - The Web team supports and develops ACME’s main corporate website as well as a basic e-commerce and customer support site.
- CRM Software
  - This is a business critical system used to send and process orders, manage customer relationships, and grow the business
- Legacy Mainframe 
  - This system knows where the "bodies are buried" and can interface with the super old widget manufacturing machines 
  - The mainframe can send emails when it is angry but can only be configured to send messages to one address

For the most part everyone on the IT team is interchangeable with the exception of Fred, Paula, and Horatio 

Fred has been there forever and is an expert in everything and needs to be a catch all on all on call policies, but he isn’t on call normally 

Paula needs to be on both the Core Services and CRM teams

Horatio needs to be on both the legacy mainframe on-call and on helpdesk team 1, he is getting trained up but isn’t ready to move over to the IT team full time. 


## Services
There is a NOC team of 6 people; they respond to blinkenlights and can escalate to IT (via Incident workflows?)
IT team has some internal services as well
Asset tracking
Backup software 

** Create some common services for IT

** Also some people ops kinds of tasks - like password resets

Integrations? - to use for sample EOs?
Service Dependencies

Event Orchestrations
For the NOC - things they know they can handle vs things that should directly escalate to IT

EOs between services with the same incoming data source
