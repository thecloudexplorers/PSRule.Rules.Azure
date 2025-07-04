---
severity: Important
pillar: Culture
category: Azure DevOps Foundation
resource: Azure DevOps Project
online version: https://azure.github.io/PSRule.Rules.Azure/en/rules/Azure.DevOps.Project.TeamStructure/
---

# Azure DevOps projects should have a clear team structure defined

## SYNOPSIS

Azure DevOps projects should have a clear team structure defined.

## DESCRIPTION

Azure DevOps projects benefit from having well-defined team structures that support effective collaboration and clear ownership. This includes configuring version control and process templates that align with organizational standards.

## RECOMMENDATION

Consider configuring:

- Version control capabilities (Git or TFVC)
- Process templates that define work item types and workflows
- Clear team organization and permissions

## EXAMPLES

### Configure with Git version control

```json
{
  "type": "Microsoft.VisualStudio/account/project",
  "properties": {
    "capabilities": {
      "versioncontrol": {
        "sourceControlType": "Git"
      },
      "processTemplate": {
        "templateTypeId": "adcc42ab-9882-485e-a3ed-7678f01f66bc"
      }
    }
  }
}
```

## LINKS

- [Culture pillar](https://learn.microsoft.com/training/modules/introduce-foundation-pillars-devops/3-explore-first-foundation)
- [Azure DevOps Projects](https://learn.microsoft.com/azure/devops/organizations/projects/)
- [Process templates](https://learn.microsoft.com/azure/devops/boards/work-items/guidance/choose-process)