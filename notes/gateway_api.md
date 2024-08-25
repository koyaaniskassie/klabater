It's basically Ingress' successor according to documentation


# Resource model
- GatewayClass - Definition of gateways with common config and anaged by a controller. Basically describes a controller
- Gateway - Defines an instance of traffic handling infra ssuch as cloud load balancer. 
- HTTP Route - Defines HTTP-specific rruules for mapping traffic from a Gateway listener to a representation of backend network endpoints, usually Services


