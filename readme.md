# Week 3 Project - Dealing with Toil at UpCommerce

## Ticketing System Challenges

The ticketing system for alert management had been a major point of contention among engineers. Complaints included recurring obsolete issues and a lack of clear prioritization for incoming issues. An example of the ticketing system's output is as follows:

```
Zone XQ: EndpointRegistrationTransientFailure
Zone OH-1: EndpointRegistrationTransientFailure
Zone OH-1: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone OH-1: EndpointRegistrationTransientFailure
Zone OH-1: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone AB: EndpointRegistrationTransientFailure
Zone AB: LLMBatchProcessingJobFailures
Zone AB: EndpointRegistrationFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone OH-1: EndpointRegistrationTransientFailure
Zone OH-1: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone AB: EndpointRegistrationTransientFailure
Zone AB: LLMBatchProcessingJobFailures
Zone AB: TooFewEndpointsRegistered
Zone AB: LLMModelStale
Zone OH-1: EndpointRegistrationTransientFailure
Zone OH-1: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
Zone AB: EndpointRegistrationTransientFailure
Zone AB: LLMBatchProcessingJobFailures
Zone AB: EndpointRegistrationFailure
Zone AB: LLMModelVeryStale
```

### Problems Identification

Based on the problem description and the example output. The following could be possible issues in the ticking system that needs to be handled.

1. Lack of event details - Looking into the details provided per event `Zone XQ: EndpointRegistrationTransientFailure`. An engineer is unable to know when the event occurred nor if the current status of the event (Example: event resolved or event assigned to engineer). There could potentially be search controls that enable filtering of the details mentioned. But this is not observable for just the output. The lack of dates on events provides a cause of old obsolete events still remaining in the system.

2. Recurring / Repeating events - As observed in the sample output `EndpointRegistrationTransientFailure` appears to be repeated and could potentially mean the same issue reported multiple times within a time period that is hinted by the event name containing the term Transient
```
Zone XQ: EndpointRegistrationTransientFailure
Zone OH-1: EndpointRegistrationTransientFailure
Zone OH-1: EndpointRegistrationTransientFailure
Zone XQ: EndpointRegistrationTransientFailure
```

3. Lack of categorization or prioritization - The sample output clearly shows there might be different categories or prioritization based on the terms like RegistrationTransientFailure or RegistrationFailure. And these are likely to be handled in a different manner but they are showed in the same output.

```
Zone XQ: EndpointRegistrationTransientFailure
Zone AB: LLMBatchProcessingJobFailures
Zone AB: EndpointRegistrationFailure
Zone AB: LLMBatchProcessingJobFailures
Zone AB: TooFewEndpointsRegistered
Zone AB: LLMModelStale
```

### Features Identification

1. Workflow & metadata management - A ticketing system should have the ablity to manage tickets within a workflow moving through different status or owner assignment. There should also be abilities to temporary ignore events like snoozing. And there should be an ability to set priorities on the events that can be used with Event Grouping. This will elevate issues associated obsoleted alerts and also prioritizing events.

2. Event Grouping - A ticket system should have the ability to group events using methods like Content-based grouping, Time-based grouping or even ML-Based grouping.
   - Content-Based Alert Grouping: enables customized alert grouping on services with predictable, homogenous alert data.
   - Time-Based Alert Grouping: will automatically add alerts to an open incident for a predetermined period, which can be helpful for services that generate many alerts.
   - ML-Based (Machine Learning Based): uses a real-time, machine learning-based algorithm to group related alerts into a single, open incident.
This helps elevate issues associated to recurring or repeating events.

### Candidate solutions

1. An incident management platform like PagerDuty provides the features required for workflow & metadata management and event grouping out of the box. A single solution like this will be able to solve the issues encountered in this problem.
2. A helpdesk ticketing system like ZenDesk provides most of the features require for workflow & metadata management with some of the event grouping features that can be complemented by integrations like prometheus alertmanger to support features like time-based grouping 

### Conclusion

This will be subjective to the stage in the growth of an organization who is implementing the system. For more mature companies that have dedicated teams for customer service engineers, product software engineers and site realiablity engineers a solution who plenty of support for functionality used by SREs like PagerDuty used with monitoring system like Prometheus  will an ideal choice. But for companies closer to the startup stage when the product software engineers handle both the product and site reliablity parts of the system. A system like Zendesk with integrations build or purchase could be beneficial in reducing required software costs and also the Tech Toil of the engineers to have to support both normal helpdesk operations and SRE operations.
    
### References
1. Prometeus: https://prometheus.io/docs
2. PagerDuty: https://support.pagerduty.com/docs/aiops
3. Zendesk: https://support.zendesk.com/hc/en-us