# Enterprise Technology Glossary

A comprehensive reference of technical terms used throughout the IBM Bob Workshop. Terms are organized by category for easy navigation.

## 📑 Table of Contents
- [Cloud & Infrastructure](#cloud--infrastructure)
- [Containers & Orchestration](#containers--orchestration)
- [Application Architecture](#application-architecture)
- [APIs & Integration](#apis--integration)
- [DevOps & CI/CD](#devops--cicd)
- [Observability & Monitoring](#observability--monitoring)
- [Security & Compliance](#security--compliance)
- [Financial Services](#financial-services)
- [Data & Databases](#data--databases)
- [Networking](#networking)

---

## Cloud & Infrastructure

**IaC (Infrastructure as Code)**  
The practice of managing and provisioning infrastructure through machine-readable definition files rather than manual configuration. Examples: Terraform, CloudFormation, Pulumi.

**Terraform**  
An open-source IaC tool that allows you to define cloud and on-premises resources in human-readable configuration files that you can version, reuse, and share.

**CloudFormation**  
AWS's native IaC service for modeling and provisioning AWS resources using JSON or YAML templates.

**Provisioning**  
The process of setting up and configuring IT infrastructure, including servers, networks, storage, and services.

**Auto-scaling**  
Automatically adjusting compute resources based on demand to maintain performance and optimize costs.

**Load Balancer**  
A device or service that distributes network traffic across multiple servers to ensure no single server becomes overwhelmed.

**Elastic Load Balancing (ELB)**  
AWS's load balancing service that automatically distributes incoming application traffic across multiple targets.

**VPC (Virtual Private Cloud)**  
An isolated virtual network within a cloud provider's infrastructure where you can launch resources in a defined virtual network.

**Subnet**  
A segmented piece of a larger network, used to organize and secure network resources.

**CIDR (Classless Inter-Domain Routing)**  
A method for allocating IP addresses and routing that replaces the older system based on classes A, B, and C.

**IAM (Identity and Access Management)**  
A framework of policies and technologies for ensuring that the right users have appropriate access to resources.

**S3 (Simple Storage Service)**  
AWS's object storage service offering scalability, data availability, security, and performance.

**EC2 (Elastic Compute Cloud)**  
AWS's web service that provides resizable compute capacity in the cloud.

**Availability Zone**  
Isolated locations within a cloud region, designed to be insulated from failures in other zones.

**Region**  
A geographical area containing multiple isolated availability zones for deploying cloud resources.

**CDN (Content Delivery Network)**  
A geographically distributed network of servers that deliver content to users based on their location.

**Edge Location**  
A site that CloudFront uses to cache copies of content for faster delivery to users.

---

## Containers & Orchestration

**Container**  
A lightweight, standalone, executable package that includes everything needed to run a piece of software, including code, runtime, libraries, and dependencies.

**Docker**  
A platform for developing, shipping, and running applications in containers.

**Dockerfile**  
A text file containing instructions for building a Docker image.

**Docker Image**  
A read-only template with instructions for creating a Docker container.

**Container Registry**  
A repository for storing and distributing container images (e.g., Docker Hub, Amazon ECR, Google Container Registry).

**Kubernetes (K8s)**  
An open-source container orchestration platform for automating deployment, scaling, and management of containerized applications.

**Pod**  
The smallest deployable unit in Kubernetes, consisting of one or more containers that share storage and network resources.

**Deployment**  
A Kubernetes resource that manages a replicated application, ensuring the desired number of pods are running.

**Service**  
A Kubernetes abstraction that defines a logical set of pods and a policy for accessing them.

**Ingress**  
A Kubernetes resource that manages external access to services, typically HTTP/HTTPS routing.

**ConfigMap**  
A Kubernetes object used to store non-confidential configuration data in key-value pairs.

**Secret**  
A Kubernetes object used to store sensitive information like passwords, tokens, or keys.

**Namespace**  
A way to divide cluster resources between multiple users or teams in Kubernetes.

**Helm**  
A package manager for Kubernetes that helps define, install, and upgrade complex Kubernetes applications.

**StatefulSet**  
A Kubernetes workload API object for managing stateful applications with persistent storage and stable network identities.

**DaemonSet**  
A Kubernetes object that ensures all (or some) nodes run a copy of a pod.

**Liveness Probe**  
A Kubernetes health check that determines if a container is running properly.

**Readiness Probe**  
A Kubernetes health check that determines if a container is ready to accept traffic.

**Resource Limits**  
Constraints on CPU and memory that a container can use in Kubernetes.

**HPA (Horizontal Pod Autoscaler)**  
Automatically scales the number of pods based on observed CPU utilization or custom metrics.

---

## Application Architecture

**Microservices**  
An architectural style that structures an application as a collection of loosely coupled, independently deployable services.

**Monolith**  
A traditional application architecture where all components are tightly integrated into a single codebase and deployment unit.

**Service Mesh**  
An infrastructure layer that handles service-to-service communication, providing features like load balancing, service discovery, and observability.

**Istio**  
An open-source service mesh that provides traffic management, security, and observability for microservices.

**Sidecar Pattern**  
A design pattern where a helper container runs alongside the main application container to provide supporting features.

**API Gateway**  
A server that acts as an entry point for clients, routing requests to appropriate backend services.

**Backend for Frontend (BFF)**  
A pattern where separate backend services are created for different frontend applications or channels.

**Event-Driven Architecture**  
A software architecture pattern where services communicate through events rather than direct calls.

**Message Queue**  
A form of asynchronous service-to-service communication used in event-driven architectures.

**Pub/Sub (Publish/Subscribe)**  
A messaging pattern where publishers send messages to topics, and subscribers receive messages from topics they're interested in.

**CQRS (Command Query Responsibility Segregation)**  
A pattern that separates read and write operations for a data store.

**Event Sourcing**  
A pattern where state changes are stored as a sequence of events rather than just the current state.

**Circuit Breaker**  
A design pattern that prevents cascading failures by stopping requests to a failing service.

**Bulkhead Pattern**  
Isolating elements of an application into pools so that if one fails, the others continue to function.

**Saga Pattern**  
A pattern for managing distributed transactions across multiple services using a sequence of local transactions.

**Strangler Fig Pattern**  
A pattern for gradually migrating a legacy system by incrementally replacing specific pieces of functionality with new services.

---

## APIs & Integration

**REST (Representational State Transfer)**  
An architectural style for designing networked applications using HTTP methods and stateless communication.

**RESTful API**  
An API that follows REST architectural principles, using standard HTTP methods (GET, POST, PUT, DELETE).

**GraphQL**  
A query language for APIs that allows clients to request exactly the data they need.

**gRPC**  
A high-performance RPC framework that uses Protocol Buffers for serialization.

**OpenAPI (Swagger)**  
A specification for describing RESTful APIs in a machine-readable format.

**API Versioning**  
The practice of managing changes to an API while maintaining backward compatibility.

**Rate Limiting**  
Controlling the number of requests a client can make to an API within a time period.

**Throttling**  
Limiting the rate at which requests are processed to prevent system overload.

**Webhook**  
A method for one application to provide real-time information to another application via HTTP callbacks.

**CORS (Cross-Origin Resource Sharing)**  
A security feature that allows or restricts web applications from making requests to a different domain.

**OAuth 2.0**  
An authorization framework that enables applications to obtain limited access to user accounts.

**JWT (JSON Web Token)**  
A compact, URL-safe means of representing claims to be transferred between two parties.

**API Contract**  
An agreement between API provider and consumer defining the expected behavior, inputs, and outputs.

**Idempotency**  
The property where an operation produces the same result regardless of how many times it's executed.

**Pagination**  
The practice of dividing large result sets into smaller, manageable pages.

---

## DevOps & CI/CD

**CI/CD (Continuous Integration/Continuous Deployment)**  
Practices that automate the integration of code changes and deployment to production.

**Pipeline**  
An automated sequence of stages (build, test, deploy) that code changes go through.

**Jenkins**  
An open-source automation server used for building CI/CD pipelines.

**GitLab CI**  
GitLab's built-in continuous integration and deployment tool.

**GitHub Actions**  
GitHub's automation platform for building CI/CD workflows.

**Artifact**  
A file or collection of files produced during the build process (e.g., compiled binaries, container images).

**Blue-Green Deployment**  
A deployment strategy that maintains two identical production environments, switching traffic between them.

**Canary Deployment**  
A deployment strategy that gradually rolls out changes to a small subset of users before full deployment.

**Rolling Deployment**  
A deployment strategy that gradually replaces instances of the old version with the new version.

**GitOps**  
A way of implementing continuous deployment where Git is the single source of truth for infrastructure and applications.

**Infrastructure Drift**  
When the actual state of infrastructure diverges from the defined state in IaC configurations.

---

## Observability & Monitoring

**Observability**  
The ability to understand the internal state of a system based on its external outputs (logs, metrics, traces).

**Monitoring**  
The practice of collecting, analyzing, and using data to track system performance and health.

**Metrics**  
Quantitative measurements of system behavior over time (e.g., CPU usage, request rate, error rate).

**Logs**  
Records of events that occurred in a system, typically timestamped and containing contextual information.

**Traces**  
Records of the path a request takes through a distributed system, showing timing and dependencies.

**Distributed Tracing**  
The practice of tracking requests as they flow through multiple services in a distributed system.

**APM (Application Performance Monitoring)**  
Tools and practices for monitoring application performance and user experience.

**Prometheus**  
An open-source monitoring and alerting toolkit designed for reliability and scalability.

**Grafana**  
An open-source platform for monitoring and observability with customizable dashboards.

**ELK Stack (Elasticsearch, Logstash, Kibana)**  
A popular log management and analysis platform.

**Jaeger**  
An open-source distributed tracing system for monitoring microservices-based architectures.

**SLI (Service Level Indicator)**  
A quantitative measure of a service's behavior (e.g., latency, error rate, throughput).

**SLO (Service Level Objective)**  
A target value or range for an SLI that defines acceptable service performance.

**SLA (Service Level Agreement)**  
A formal agreement between service provider and customer defining expected service levels.

**Alert**  
A notification triggered when a metric crosses a defined threshold or condition is met.

**Incident**  
An unplanned interruption or reduction in quality of a service.

**Postmortem**  
A written record of an incident, its impact, root cause, and actions taken to prevent recurrence.

**MTTR (Mean Time To Recovery)**  
The average time it takes to restore a service after an incident.

**MTBF (Mean Time Between Failures)**  
The average time between system failures.

---

## Security & Compliance

**Authentication**  
The process of verifying the identity of a user or system.

**Authorization**  
The process of determining what an authenticated user or system is allowed to do.

**Encryption**  
The process of encoding data so that only authorized parties can access it.

**TLS/SSL (Transport Layer Security/Secure Sockets Layer)**  
Cryptographic protocols for secure communication over a network.

**Certificate**  
A digital document that verifies the identity of an entity and contains a public key.

**PKI (Public Key Infrastructure)**  
A framework for managing digital certificates and public-key encryption.

**Zero Trust**  
A security model that assumes no user or system should be trusted by default, even inside the network perimeter.

**RBAC (Role-Based Access Control)**  
An access control method that assigns permissions based on roles rather than individual users.

**Least Privilege**  
The principle of granting users only the minimum access necessary to perform their job functions.

**Secrets Management**  
The practice of securely storing, accessing, and managing sensitive information like passwords and API keys.

**Vulnerability Scanning**  
Automated testing to identify security weaknesses in systems or applications.

**Penetration Testing**  
Simulated cyber attacks to identify security vulnerabilities before malicious actors can exploit them.

**SIEM (Security Information and Event Management)**  
Technology that provides real-time analysis of security alerts generated by applications and network hardware.

**Compliance**  
Adherence to laws, regulations, standards, and policies relevant to an organization.

**GDPR (General Data Protection Regulation)**  
EU regulation on data protection and privacy for individuals within the European Union.

**SOC 2 (Service Organization Control 2)**  
An auditing procedure that ensures service providers securely manage data to protect client interests.

**PCI DSS (Payment Card Industry Data Security Standard)**  
Security standards for organizations that handle credit card information.

---

## Financial Services

**Trading System**  
Software platform that facilitates the buying and selling of financial instruments.

**Order Management System (OMS)**  
Software that tracks and manages the lifecycle of trade orders.

**Execution Management System (EMS)**  
Software that enables traders to execute orders across multiple markets and venues.

**Market Data**  
Real-time and historical information about financial instruments, including prices, volumes, and quotes.

**Tick Data**  
The most granular level of market data, showing every price change and trade.

**Order Book**  
A list of buy and sell orders for a specific security or financial instrument.

**Liquidity**  
The ease with which an asset can be bought or sold without affecting its price.

**Slippage**  
The difference between the expected price of a trade and the actual execution price.

**Latency**  
The time delay between initiating an action and receiving a response, critical in high-frequency trading.

**Risk Management**  
The process of identifying, assessing, and controlling financial risks.

**VaR (Value at Risk)**  
A statistical measure of the potential loss in value of a portfolio over a defined period for a given confidence interval.

**Greeks**  
Measures of risk in options trading (Delta, Gamma, Theta, Vega, Rho).

**Position**  
The amount of a security, commodity, or currency held by an individual or entity.

**Portfolio**  
A collection of financial investments like stocks, bonds, commodities, and cash equivalents.

**Settlement**  
The process of transferring securities and cash to complete a trade.

**Clearing**  
The process of reconciling purchase and sale orders and ensuring the transfer of securities and funds.

**Reconciliation**  
The process of comparing records to ensure they are in agreement and accurate.

**Compliance Engine**  
Software that monitors transactions and activities to ensure adherence to regulatory requirements.

**KYC (Know Your Customer)**  
The process of verifying the identity of clients to prevent fraud and money laundering.

**AML (Anti-Money Laundering)**  
Regulations and procedures designed to prevent criminals from disguising illegally obtained funds as legitimate income.

**MiFID II (Markets in Financial Instruments Directive)**  
EU legislation that regulates firms providing services to clients linked to financial instruments.

**Dodd-Frank Act**  
US federal law that places regulation of the financial industry in the hands of the government.

**Basel III**  
International regulatory framework for banks addressing capital adequacy, stress testing, and liquidity risk.

**Audit Trail**  
A chronological record of system activities that enables reconstruction and examination of events.

**Trade Lifecycle**  
The sequence of events from order placement through execution, clearing, and settlement.

---

## Data & Databases

**RDBMS (Relational Database Management System)**  
A database management system based on the relational model (e.g., PostgreSQL, MySQL, Oracle).

**NoSQL**  
Non-relational databases designed for specific data models and flexible schemas (e.g., MongoDB, Cassandra, Redis).

**ACID (Atomicity, Consistency, Isolation, Durability)**  
Properties that guarantee database transactions are processed reliably.

**CAP Theorem**  
States that a distributed system can only guarantee two of three properties: Consistency, Availability, Partition tolerance.

**Sharding**  
A database partitioning technique that splits data across multiple machines.

**Replication**  
The process of copying data from one database to another to ensure availability and fault tolerance.

**Data Lake**  
A centralized repository that stores structured and unstructured data at any scale.

**Data Warehouse**  
A system used for reporting and data analysis, typically containing historical data from multiple sources.

**ETL (Extract, Transform, Load)**  
The process of extracting data from sources, transforming it, and loading it into a target system.

**Schema**  
The structure that defines the organization of data in a database.

**Index**  
A database structure that improves the speed of data retrieval operations.

**Query Optimization**  
The process of improving database query performance through better query design or execution plans.

**Connection Pool**  
A cache of database connections maintained to improve performance by reusing connections.

**ORM (Object-Relational Mapping)**  
A technique for converting data between incompatible type systems in object-oriented programming and relational databases.

---

## Networking

**DNS (Domain Name System)**  
The system that translates human-readable domain names into IP addresses.

**TCP/IP (Transmission Control Protocol/Internet Protocol)**  
The fundamental communication protocols of the internet.

**HTTP/HTTPS (Hypertext Transfer Protocol/Secure)**  
Protocols for transmitting web pages and data over the internet.

**Firewall**  
A network security system that monitors and controls incoming and outgoing network traffic.

**Proxy**  
An intermediary server that forwards requests from clients to other servers.

**Reverse Proxy**  
A server that sits in front of web servers and forwards client requests to those servers.

**NAT (Network Address Translation)**  
A method of remapping IP addresses by modifying network address information in packet headers.

**VPN (Virtual Private Network)**  
A secure connection over the internet that encrypts data and hides IP addresses.

**Bandwidth**  
The maximum rate of data transfer across a network path.

**Throughput**  
The actual rate of successful data transfer over a network.

**Latency**  
The time it takes for data to travel from source to destination.

**Packet**  
A unit of data transmitted over a network.

**Protocol**  
A set of rules governing data communication between devices.

---

## Quick Reference Tips

### Using This Glossary
- **Ctrl/Cmd + F**: Search for specific terms
- **Context matters**: Some terms have different meanings in different domains
- **Related terms**: Many concepts are interconnected - explore related definitions
- **Ask Bob**: Use Bob to explain how these concepts apply to specific code examples

### Learning Strategy
1. Don't try to memorize everything
2. Reference as needed during exercises
3. Focus on terms relevant to your role
4. Build understanding through practical application

---

**Need more detail on a term?** Ask Bob! Example: "Explain what a service mesh is and how it's used in microservices architectures."