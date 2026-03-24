# Contributing to IBM Bob Workshop

Thank you for your interest in improving the IBM Bob Workshop! This document provides guidelines for contributing new content, exercises, and improvements.

## Table of Contents

- [Getting Started](#getting-started)
- [Content Guidelines](#content-guidelines)
- [Adding New Modules](#adding-new-modules)
- [Improving Existing Modules](#improving-existing-modules)
- [Testing Workshop Materials](#testing-workshop-materials)
- [Submission Process](#submission-process)
- [Code of Conduct](#code-of-conduct)

## Getting Started

### Prerequisites

- Familiarity with Bob's capabilities and features
- Understanding of the target audience (enterprise developers, infrastructure engineers, etc.)
- Access to the workshop repository
- Basic knowledge of Git and GitHub workflows

### Repository Structure

```
ibm-bob-workshop/
├── README.md                    # Main workshop overview
├── WORKSHOP_GUIDE.md           # Facilitator guide
├── CONTRIBUTING.md             # This file
├── shared/                     # Common resources
├── module-X-name/              # Individual modules
└── solutions/                  # Reference solutions
```

## Content Guidelines

### Quality Standards

All workshop content must meet these standards:

#### 1. **Realistic and Enterprise-Appropriate**
- Use realistic enterprise scenarios and data
- Avoid toy examples or oversimplified code
- Include real-world complexity and edge cases
- Reflect actual enterprise constraints and requirements

#### 2. **Educational Value**
- Clear learning objectives for each exercise
- Progressive difficulty (start simple, build complexity)
- Hands-on, interactive exercises
- Measurable success criteria

#### 3. **Bob-Focused**
- Demonstrate specific Bob capabilities
- Include example prompts that work well
- Show multiple ways to use Bob for the same task
- Highlight Bob's strengths in the scenario

#### 4. **Well-Documented**
- Clear instructions and context
- Comprehensive README files
- Inline comments in code samples
- Troubleshooting tips

#### 5. **Tested and Validated**
- All exercises tested with Bob
- Sample prompts verified to work
- Success criteria achievable
- Timing estimates accurate

### Writing Style

- **Be concise:** Get to the point quickly
- **Be specific:** Provide concrete examples
- **Be practical:** Focus on real-world applicability
- **Be inclusive:** Use accessible language
- **Be professional:** Maintain enterprise tone

### File Naming Conventions

- Use lowercase with hyphens: `module-name-here.md`
- Be descriptive: `payment-service-config.yml` not `config.yml`
- Group related files in directories
- Use consistent extensions: `.md` for docs, `.yml` for configs

## Adding New Modules

### Module Structure

Each module should follow this structure:

```
module-X-name/
├── README.md                   # Module overview and exercises
├── scenario.md                 # Detailed scenario context
├── success-criteria.md         # Completion requirements
├── [service-directories]/      # Code and configurations
├── docs/                       # Documentation
├── logs/                       # Sample logs (if applicable)
├── config/                     # Configuration files
└── incidents/                  # Incident reports (if applicable)
```

### Module Checklist

Before submitting a new module, ensure:

- [ ] **README.md** includes:
  - Duration estimate (15-30 minutes)
  - Difficulty level
  - Learning objectives
  - 3-5 exercises with sample prompts
  - Success criteria
  - Tips for success

- [ ] **scenario.md** provides:
  - Company/project background
  - Current challenges
  - Technical architecture
  - Business context
  - Stakeholder expectations

- [ ] **Code/Configurations** are:
  - Realistic and enterprise-grade
  - Well-commented
  - Contain intentional issues for discovery
  - Include both good and problematic examples

- [ ] **Exercises** are:
  - Hands-on and interactive
  - Progressive in difficulty
  - Achievable in stated timeframe
  - Include multiple sample prompts

- [ ] **Solutions** document:
  - Multiple valid approaches
  - Example Bob interactions
  - Common pitfalls
  - Best practices

### Module Template

Use this template when creating a new module:

```markdown
# Module X: [Module Name]

**Duration:** [15-30] minutes  
**Difficulty:** [Beginner/Intermediate/Advanced]  
**Target Audience:** [Role/Persona]

## Overview

[2-3 sentences describing the module and what participants will learn]

## Learning Objectives

By completing this module, you will learn how to use Bob to:

1. [Objective 1]
2. [Objective 2]
3. [Objective 3]

## Scenario

[Brief scenario description - link to scenario.md for details]

## Module Structure

[Directory tree showing module contents]

## Exercises

### Exercise 1: [Name] ([X] minutes)

**Objective**: [What participants will accomplish]

**Tasks**:
1. [Task 1]
2. [Task 2]

**Sample Prompts**:
- "[Example prompt 1]"
- "[Example prompt 2]"

**Success Criteria**: [How to know the exercise is complete]

---

[Repeat for each exercise]

## Tips for Success

1. [Tip 1]
2. [Tip 2]

## Next Steps

[What to do after completing the module]
```

## Improving Existing Modules

### Types of Improvements

We welcome improvements in these areas:

1. **Content Enhancements**
   - Additional exercises
   - Better sample prompts
   - More realistic scenarios
   - Improved documentation

2. **Code Quality**
   - More realistic code samples
   - Better comments
   - Additional edge cases
   - Improved configurations

3. **Clarity Improvements**
   - Better explanations
   - Clearer instructions
   - More examples
   - Updated screenshots

4. **Bug Fixes**
   - Correcting errors
   - Fixing broken links
   - Updating outdated information
   - Resolving inconsistencies

### Making Changes

1. **Small Changes** (typos, minor clarifications):
   - Create a pull request directly
   - Describe the change in PR description

2. **Medium Changes** (new exercises, significant updates):
   - Open an issue first to discuss
   - Get feedback before implementing
   - Create PR with detailed description

3. **Large Changes** (new modules, major restructuring):
   - Open an issue with detailed proposal
   - Discuss with maintainers
   - Create design document if needed
   - Implement in phases with multiple PRs

## Testing Workshop Materials

### Before Submitting

Test your content thoroughly:

#### 1. **Self-Test**
- Complete all exercises yourself
- Verify all sample prompts work with Bob
- Check timing estimates are accurate
- Ensure success criteria are achievable

#### 2. **Peer Review**
- Have a colleague complete the exercises
- Gather feedback on clarity and difficulty
- Identify confusing sections
- Validate learning objectives are met

#### 3. **Bob Validation**
- Test all sample prompts with Bob
- Verify Bob can complete the exercises
- Check that Bob's responses are helpful
- Ensure prompts demonstrate Bob's capabilities

#### 4. **Technical Validation**
- All code compiles/runs (if applicable)
- All links work
- All files referenced exist
- Directory structure is correct

### Testing Checklist

- [ ] All exercises completed successfully
- [ ] Timing estimates validated
- [ ] Sample prompts tested with Bob
- [ ] Success criteria achievable
- [ ] No broken links or references
- [ ] Code samples work as expected
- [ ] Documentation is clear
- [ ] Peer reviewed by at least one person

## Submission Process

### Step 1: Prepare Your Contribution

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Make your changes
4. Test thoroughly (see Testing section)
5. Commit with clear messages

### Step 2: Create Pull Request

1. Push your branch to your fork
2. Open a pull request against `main`
3. Fill out the PR template completely
4. Link any related issues

### Pull Request Template

```markdown
## Description
[Describe what this PR does]

## Type of Change
- [ ] New module
- [ ] Exercise improvement
- [ ] Documentation update
- [ ] Bug fix
- [ ] Other: [describe]

## Testing Completed
- [ ] Self-tested all exercises
- [ ] Peer reviewed
- [ ] Bob validation completed
- [ ] Technical validation passed

## Checklist
- [ ] Follows content guidelines
- [ ] Documentation updated
- [ ] Solutions provided (if applicable)
- [ ] Timing estimates included
- [ ] Success criteria defined

## Additional Notes
[Any additional context or information]
```

### Step 3: Review Process

1. Maintainers will review your PR
2. Address any feedback or requested changes
3. Once approved, your PR will be merged
4. Your contribution will be included in the next workshop release

## Code of Conduct

### Our Standards

- **Be respectful:** Treat all contributors with respect
- **Be constructive:** Provide helpful, actionable feedback
- **Be collaborative:** Work together to improve the workshop
- **Be professional:** Maintain enterprise-appropriate tone
- **Be inclusive:** Welcome contributors of all backgrounds

### Unacceptable Behavior

- Harassment or discrimination
- Trolling or insulting comments
- Personal attacks
- Publishing others' private information
- Other unprofessional conduct

### Reporting

If you experience or witness unacceptable behavior, please report it to the workshop maintainers.

## Questions?

- **General Questions:** Open an issue with the `question` label
- **Technical Issues:** Open an issue with the `bug` label
- **Feature Requests:** Open an issue with the `enhancement` label
- **Security Concerns:** Email the maintainers directly

## Recognition

Contributors will be recognized in:
- Repository contributors list
- Release notes for significant contributions
- Workshop credits (for major contributions)

## License

By contributing to this project, you agree that your contributions will be licensed under the same license as the project.

---

**Thank you for helping make the IBM Bob Workshop better!**

For questions or assistance, please open an issue or contact the workshop maintainers.