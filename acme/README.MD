# About ACME Inc. 

At Acme Inc, our mission is to provide high-quality widgets that meet the needs of our customers while maintaining the highest levels of customer service and satisfaction. We strive to be a leader in the industry by continuously improving our products, processes, and customer experiences.

## Acme People
They are deploying PagerDuty for two main teams right now:
- Customer facing helpdesk
  - Team 1 - 6 people
  - Team 2 - 6 people
  - For the most part everyone on the helpdesk team is interchangeable with the exception Horatio
    - Horatio needs to be on both the legacy mainframe on-call and on helpdesk team 1, he is getting trained up on the mainframe but isn’t ready to move over to the IT team full time
- IT type people
  - 16 FTE's
  - For the most part everyone on the IT team is interchangeable with the exception of Fred, Paula
  - Fred has been there forever and is an expert in everything and needs to be a catch all on all on call policies, but he isn’t on call normally
  - Paula needs to be on both the Core Services and CRM


There is a need for a few other people that want to know about how IT is going, This includes the CEO, the sales manager, and the manufacturing foreman.
- The CEO wants to know about ALL IT issues.
- The sales manager both want to know when the CRM application is having issues, but they don’t care about the details. They just want to keep a track of it. 
- The manufacturing foreman needs to know about issues with the CRM and mainframe systems.


## Schedules

### Helpdesk
Follow the sun model split on two teams, each with 12-hour shifts.
- Each team is made up of 6 people
- The rotation is a week for both teams.
### The IT team
24x7 schedule with a weekly shift. And they support 4 major business areas: there is a bit of overlap as Acme Inc allows its employees to move between focus areas as needed.


## Services
- There is a NOC team of 6 people inside of the IT team; they respond to blinkenlights and can escalate to other IT teams (via Incident workflows?)

The IT team supports 4 major business services
- Core Services (active directory, DNS, DHCP, network etc)
  - They run VMware as a hypervisor and a few database servers to support the CRM software
- Web application
  - A very basic hosted ecommerce site
- CRM Software
  - This is a business critical system used to send and process orders
- Legacy Mainframe
  - This knows where the bodies are buried and can interface with the super old widget manufacturing machines
  - it can send emails when it is angry
- IT team has some internal services as well that the CEO doesn't care about as it doesn't impact the customers
  - Asset tracking
  - Backup software

** Create some common services for IT

** Also some people ops kinds of tasks - like password resets

Integrations? - to use for sample EOs?
Service Dependencies

Event Orchestrations
For the NOC - things they know they can handle vs things that should directly escalate to IT

EOs between services with the same incoming data source



## How to Use
- Sign up for a [Developer Account](https://developer.pagerduty.com/sign-up/). This account will provide you with a sandbox that will allow you to build and modify things in a PagerDuty account without messing with production data.
- [Generate a PagerDuty REST API key](https://support.pagerduty.com/docs/generating-api-keys).
- Using that key, create a .creds file and place your API key in it, this will be ignored by git and is a best practice to not accidentally commit your credentials to git. 
  - in reality you want to use some type of secrets manager and use a session variable to store your API credentials as they are the `keys to your PagerDuty kingdom`.  but for the purposes of getting you up and running the .creds file is ok for now
  - Talk to your security department and use common sense in storing critical data
- In the root directory, run a `terraform init` in the command line.
- Run `terraform plan` to see what changes this file will implement.
- If everything looks good in your plan, run `terraform apply`. This will show you the plan again and then ask you to confirm whether you want to perform the proposed actions. Type `yes`.

When the process is complete your PagerDuty instance should now have all the resources listed below created.


The code here will create the following resources in PagerDuty based on the content in the following files.

- users.tf
  - **Users**
- teams.tf
  - **Teams**
  - **Team Memberships**
- escalation_policy.tf
  - **Escalation Policy**
- schedules.tf
  - **Schedules**
- services.tf
  - **Services**
  - **Service Integrations**
  - **Business Service**
  - **Service Dependency**
- event_orchestration.tf
  - **Event Orchestration**