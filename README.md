# IBM Bob Workshop - Hands-On Enterprise AI Assistant Experience

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Workshop Duration](https://img.shields.io/badge/Duration-40%20minutes-blue.svg)]()
[![Modules](https://img.shields.io/badge/Modules-2%20Active-green.svg)]()
[![Files](https://img.shields.io/badge/Files-165%2B-orange.svg)]()

Welcome to the IBM Bob Workshop! This repository provides a self-contained, hands-on environment for experiencing Bob, IBM's AI-powered coding assistant, through realistic enterprise scenarios.

> **🎯 Perfect for**: Developers, DevOps engineers, and IT professionals looking to experience AI-assisted development in realistic enterprise contexts.

## 📋 Table of Contents

- [Workshop Overview](#-workshop-overview)
- [Learning Objectives](#-learning-objectives)
- [Prerequisites](#-prerequisites)
- [Repository Structure](#-repository-structure)
- [Getting Started](#-getting-started)
- [Module Descriptions](#-module-descriptions)
- [Workshop Flow](#-workshop-flow)
- [Quick Navigation](#-quick-navigation)
- [Contributing](#-contributing)
- [License](#-license)
- [Support](#-support)

## 🎯 Workshop Overview

This 40-minute interactive workshop demonstrates Bob's capabilities across two enterprise personas:
- **Application Engineer** (25 minutes)
- **IT Infrastructure Engineer** (15 minutes)


Each module includes real-world scenarios, sample codebases, and guided exercises that showcase Bob's ability to understand context, navigate complex systems, and provide intelligent assistance.

## 📚 Learning Objectives

By the end of this workshop, you will:
- Understand how Bob assists with enterprise development workflows
- Experience Bob's code navigation and analysis capabilities
- Learn effective prompting techniques for AI-assisted development
- See how Bob handles domain-specific terminology and compliance requirements
- Gain confidence using AI assistants in your daily work

## ✅ Prerequisites

**None!** This workshop is completely self-contained:
- No prior Bob experience required
- No software installation needed (uses your existing Bob setup)
- All sample code and resources included
- Suitable for developers of all experience levels

## 📁 Repository Structure

```
ibm-bob-workshop/
├── README.md                          # This file
├── WORKSHOP_GUIDE.md                  # Facilitator guide with timing and tips
├── CONTRIBUTING.md                    # Contribution guidelines
├── shared/                            # Common resources for all modules
│   ├── README.md                      # Overview of shared resources
│   ├── glossary.md                    # 100+ enterprise terms and definitions
│   ├── bob-quick-reference.md         # Bob commands and best practices
│   └── sample-prompts.md              # 50+ example prompts by use case
├── module-1-app-engineering/          # Application Engineering (25 min)
│   ├── README.md                      # Module overview and exercises
│   ├── scenario.md                    # Detailed scenario context
│   ├── success-criteria.md            # Completion requirements
│   ├── order-service/                 # Order management microservice
│   ├── payment-service/               # Payment processing microservice
│   ├── inventory-service/             # Inventory management microservice
│   ├── kafka/                         # Message broker configuration
│   ├── api-gateway/                   # API Gateway routes and policies
│   ├── service-mesh/                  # Istio configuration
│   ├── docs/                          # Architecture, APIs, runbooks, ADRs
│   ├── logs/                          # Production logs with real errors
│   ├── config/                        # Kubernetes and monitoring configs
│   ├── incidents/                     # Incident reports and postmortems
│   └── tests/                         # Integration and performance tests
├── module-2-infrastructure/           # IT Infrastructure (15 min)
│   ├── README.md                      # Module overview and exercises
│   ├── scenario.md                    # Detailed scenario context
│   ├── success-criteria.md            # Completion requirements
│   ├── cloud-infrastructure/          # Terraform, Ansible, scripts
│   ├── monitoring/                    # Metrics, alerts, dashboards
│   ├── network/                       # Firewall, load balancer, VPN configs
│   ├── security/                      # Vulnerability scans, compliance
│   ├── docs/                          # Architecture and planning docs
│   └── incidents/                     # Incident reports and RCA templates
└── solutions/                         # Reference solutions for exercises
    ├── module-1-solutions.md          # Application Engineering solutions
    └── module-2-solutions.md          # Infrastructure solutions
```

## 🚀 Getting Started

### For Workshop Participants

1. **Clone this repository:**
   ```bash
   git clone https://github.com/YOUR-ORG/ibm-bob-workshop.git
   cd ibm-bob-workshop
   ```
   
   > **Note**: Replace `YOUR-ORG` with the actual GitHub organization or username.

2. **Review shared resources:**
   - Start with `shared/bob-quick-reference.md` for Bob basics
   - Browse `shared/glossary.md` for enterprise terminology
   - Check `shared/sample-prompts.md` for prompting examples

3. **Choose your path:**
   - **Guided Workshop**: Follow along with the facilitator
   - **Self-Paced**: Start with Module 1 and progress through each module
   - **Role-Specific**: Jump directly to the module matching your role

### For Workshop Facilitators

See **[WORKSHOP_GUIDE.md](WORKSHOP_GUIDE.md)** for:
- Detailed timing breakdown
- Facilitation tips and talking points
- Common questions and answers
- Adaptation strategies for different audiences

## 📖 Module Descriptions

### Module 1: Application Engineering (25 minutes)
**Persona**: Application developer working on e-commerce microservices

**Scenario**: Production crisis at TechMart Global - a microservices platform experiencing payment timeouts, Kafka consumer lag, memory leaks, and intermittent 503 errors.

**What You'll Do**:
- Navigate a complex microservices architecture (Order, Payment, Inventory services)
- Analyze production logs to identify root causes
- Trace failed requests across distributed services
- Troubleshoot Kafka consumer lag and memory leaks
- Draft incident reports and propose architectural improvements
- Review code quality and identify potential issues

**Key Skills**: Code navigation, log analysis, distributed tracing, incident response, architectural reasoning

**Files**: 71 files including Java microservices, Kafka configs, Kubernetes manifests, logs, and documentation

---

### Module 2: IT Infrastructure (15 minutes)
**Persona**: Infrastructure engineer at GlobalTech Enterprise

**Scenario**: Managing hybrid cloud infrastructure (500+ servers) facing capacity issues, security vulnerabilities, network outages, and compliance gaps.

**What You'll Do**:
- Search infrastructure configs for security vulnerabilities
- Analyze capacity trends and predict resource needs
- Troubleshoot VPN connectivity and network outages
- Review vulnerability scan results and prioritize patching
- Draft runbooks and incident reports
- Plan capacity expansion and architectural improvements

**Key Skills**: Infrastructure analysis, security assessment, capacity planning, troubleshooting, documentation

**Files**: 44 files including Terraform configs, Ansible playbooks, monitoring metrics, security scans, and network configs

---

### Module 3: Financial Services (Planned)
**Status**: Coming in future release

This module will cover financial services scenarios including trading systems, risk calculations, and regulatory compliance.

## 🎓 Workshop Flow

```
┌─────────────────────────────────────────────────────────────┐
│ Introduction (5 min)                                        │
│ • Workshop overview                                         │
│ • Bob capabilities introduction                             │
│ • Navigation and setup                                      │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ Module 1: Application Engineering (25 min)                  │
│ • Search & navigate microservices codebase                  │
│ • Analyze production logs and troubleshoot issues           │
│ • Synthesize fragmented documentation                       │
│ • Draft incident reports and postmortems                    │
│ • Review code quality and architectural decisions           │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ Module 2: IT Infrastructure (15 min)                        │
│ • Search infrastructure configs for security issues         │
│ • Analyze capacity trends and alert patterns                │
│ • Troubleshoot network outages and storage issues           │
│ • Draft runbooks and incident reports                       │
│ • Plan capacity expansion and improvements                  │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ Wrap-up & Q&A (5 min)                                       │
│ • Key takeaways                                             │
│ • Next steps and resources                                  │
│ • Q&A and feedback                                          │
└─────────────────────────────────────────────────────────────┘
```

## 💡 Quick Navigation

- **[Shared Resources](shared/README.md)** - Glossary, quick reference, sample prompts
- **[Module 1: Application Engineering](module-1-app-engineering/README.md)** - Microservices development
- **[Module 2: IT Infrastructure](module-2-infrastructure/README.md)** - Infrastructure management
- **[Solutions](solutions/)** - Reference solutions for all exercises
- **[Workshop Guide](WORKSHOP_GUIDE.md)** - Facilitator instructions
- **[Contributing](CONTRIBUTING.md)** - Contribution guidelines

## 🤝 Contributing

This workshop is designed for IBM internal use. For suggestions or improvements, see **[CONTRIBUTING.md](CONTRIBUTING.md)** for:
- Content quality standards
- Guidelines for adding new modules
- Testing requirements
- Submission process

## 📄 License

Copyright © 2024 IBM Corporation. All rights reserved.

This workshop material is for IBM internal training purposes.

## 🆘 Support

- **During Workshop**: Ask your facilitator
- **Technical Issues**: Contact your IBM Bob support team
- **Content Questions**: Open an issue in this repository

---

**Ready to get started?** Open `shared/bob-quick-reference.md` to learn Bob basics, then dive into Module 1!
