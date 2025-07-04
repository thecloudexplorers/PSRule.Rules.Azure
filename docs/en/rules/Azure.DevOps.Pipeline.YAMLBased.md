---
severity: Important
pillar: Architecture
category: Azure DevOps Foundation
resource: Azure DevOps Build Definition
online version: https://azure.github.io/PSRule.Rules.Azure/en/rules/Azure.DevOps.Pipeline.YAMLBased/
---

# Azure DevOps build definitions should use YAML-based pipelines

## SYNOPSIS

Azure DevOps build definitions should use YAML-based pipelines.

## DESCRIPTION

YAML-based pipelines in Azure DevOps provide better version control, reusability, and maintainability compared to classic build definitions. They enable infrastructure as code practices for CI/CD pipelines.

## RECOMMENDATION

Consider:

- Using YAML pipeline files stored in your repository
- Version controlling your pipeline definitions
- Implementing reusable pipeline templates
- Following pipeline as code best practices

## EXAMPLES

### Configure YAML-based pipeline

```json
{
  "type": "Microsoft.VisualStudio/account/project/buildDefinition",
  "properties": {
    "type": "build",
    "yamlFilename": "azure-pipelines.yml",
    "repository": {
      "type": "TfsGit",
      "defaultBranch": "refs/heads/main"
    }
  }
}
```

### Sample YAML pipeline file

```yaml
# azure-pipelines.yml
trigger:
- main

pool:
  vmImage: 'ubuntu-latest'

steps:
- task: DotNetCoreCLI@2
  displayName: 'Build'
  inputs:
    command: 'build'
    projects: '**/*.csproj'
```

## LINKS

- [Architecture pillar](https://learn.microsoft.com/training/modules/define-foundation-pillars/2-explore-third-foundation-pillar)
- [Continuous Integration](https://learn.microsoft.com/training/modules/analyze-devops-continuous-planning-intergration/3-analyze-continuous-integration)
- [YAML schema reference](https://learn.microsoft.com/azure/devops/pipelines/yaml-schema/)
- [Pipeline as code](https://learn.microsoft.com/azure/devops/pipelines/process/pipeline-as-code)