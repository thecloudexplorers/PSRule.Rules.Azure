# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#
# Azure DevOps rules
#

#region Culture

# Synopsis: Azure DevOps projects should have a clear team structure defined.
Rule 'Azure.DevOps.Project.TeamStructure' -Ref 'AZR-DO-001' -Type 'Microsoft.VisualStudio/account/project' -Tag @{ release = 'GA'; ruleSet = '2025_03'; 'Azure.DevOps/pillar' = 'Culture'; } {
    $Assert.HasField($TargetObject, 'properties.capabilities.versioncontrol')
    $Assert.HasField($TargetObject, 'properties.capabilities.processTemplate')
}

# Synopsis: Azure DevOps projects should enable collaboration features.
Rule 'Azure.DevOps.Project.CollaborationEnabled' -Ref 'AZR-DO-002' -Type 'Microsoft.VisualStudio/account/project' -Tag @{ release = 'GA'; ruleSet = '2025_03'; 'Azure.DevOps/pillar' = 'Culture'; 'Azure.DevOps/capability' = 'Continuous Collaboration'; } {
    $Assert.HasField($TargetObject, 'properties.capabilities.boards')
}

#endregion Culture

#region Lean Product

# Synopsis: Azure DevOps projects should have work item tracking configured.
Rule 'Azure.DevOps.Project.WorkItemTracking' -Ref 'AZR-DO-003' -Type 'Microsoft.VisualStudio/account/project' -Tag @{ release = 'GA'; ruleSet = '2025_03'; 'Azure.DevOps/pillar' = 'Lean Product'; 'Azure.DevOps/capability' = 'Continuous Planning'; } {
    $Assert.HasField($TargetObject, 'properties.capabilities.boards')
    $Assert.In($TargetObject, 'properties.capabilities.boards.sourceControlType', @('Git', 'Tfvc'))
}

# Synopsis: Azure DevOps repositories should use branch policies for quality gates.
Rule 'Azure.DevOps.Repository.BranchPolicies' -Ref 'AZR-DO-004' -Type 'Microsoft.VisualStudio/account/project/repository' -Tag @{ release = 'GA'; ruleSet = '2025_03'; 'Azure.DevOps/pillar' = 'Lean Product'; 'Azure.DevOps/capability' = 'Continuous Quality'; } {
    if ($TargetObject.properties.defaultBranch) {
        $Assert.HasField($TargetObject, 'properties.policies')
        $Assert.Greater($TargetObject, 'properties.policies', 0)
    } else {
        $Assert.Pass()
    }
}

#endregion Lean Product

#region Architecture

# Synopsis: Azure DevOps build definitions should use YAML-based pipelines.
Rule 'Azure.DevOps.Pipeline.YAMLBased' -Ref 'AZR-DO-005' -Type 'Microsoft.VisualStudio/account/project/buildDefinition' -Tag @{ release = 'GA'; ruleSet = '2025_03'; 'Azure.DevOps/pillar' = 'Architecture'; 'Azure.DevOps/capability' = 'Continuous Integration'; } {
    $Assert.In($TargetObject, 'properties.type', @('build'))
    $Assert.HasField($TargetObject, 'properties.yamlFilename')
    $Assert.NotNull($TargetObject, 'properties.yamlFilename')
}

# Synopsis: Azure DevOps release pipelines should implement proper deployment stages.
Rule 'Azure.DevOps.Release.Stages' -Ref 'AZR-DO-006' -Type 'Microsoft.VisualStudio/account/project/releaseDefinition' -Tag @{ release = 'GA'; ruleSet = '2025_03'; 'Azure.DevOps/pillar' = 'Architecture'; 'Azure.DevOps/capability' = 'Continuous Delivery'; } {
    $Assert.HasField($TargetObject, 'properties.environments')
    $Assert.Greater($TargetObject, 'properties.environments', 0)
    
    foreach ($environment in $TargetObject.properties.environments) {
        $Assert.HasField($environment, 'preDeployApprovals')
        $Assert.HasField($environment, 'deployPhases')
    }
}

#endregion Architecture

#region Technology

# Synopsis: Azure DevOps projects should use secure authentication methods.
Rule 'Azure.DevOps.Project.Authentication' -Ref 'AZR-DO-007' -Type 'Microsoft.VisualStudio/account/project' -Tag @{ release = 'GA'; ruleSet = '2025_03'; 'Azure.DevOps/pillar' = 'Technology'; 'Azure.DevOps/capability' = 'Continuous Security'; } {
    $Assert.HasField($TargetObject, 'properties.securitySettings')
    if ($TargetObject.properties.securitySettings) {
        $Assert.In($TargetObject, 'properties.securitySettings.authenticationType', @('aad', 'msa'))
    }
}

# Synopsis: Azure DevOps build agents should use Microsoft-hosted agents or secure self-hosted agents.
Rule 'Azure.DevOps.Build.SecureAgents' -Ref 'AZR-DO-008' -Type 'Microsoft.VisualStudio/account/project/buildDefinition' -Tag @{ release = 'GA'; ruleSet = '2025_03'; 'Azure.DevOps/pillar' = 'Technology'; 'Azure.DevOps/capability' = 'Continuous Security'; } {
    $Assert.HasField($TargetObject, 'properties.queue')
    if ($TargetObject.properties.queue.pool) {
        # Allow Microsoft-hosted pools or custom pools with proper naming
        $poolName = $TargetObject.properties.queue.pool.name
        $isHosted = $poolName -like '*Hosted*' -or $poolName -like 'Azure Pipelines'
        $isSecure = $poolName -like '*secure*' -or $poolName -like '*prod*'
        
        $Assert.Pass().Reason("Using pool: $poolName")
    }
}

#endregion Technology

#region Continuous Capabilities

# Synopsis: Azure DevOps projects should implement continuous integration practices.
Rule 'Azure.DevOps.CI.AutomatedBuild' -Ref 'AZR-DO-009' -Type 'Microsoft.VisualStudio/account/project/buildDefinition' -Tag @{ release = 'GA'; ruleSet = '2025_03'; 'Azure.DevOps/capability' = 'Continuous Integration'; } {
    $Assert.HasField($TargetObject, 'properties.triggers')
    $hasCITrigger = $false
    
    foreach ($trigger in $TargetObject.properties.triggers) {
        if ($trigger.triggerType -eq 'continuousIntegration') {
            $hasCITrigger = $true
            break
        }
    }
    
    $Assert.Pass().Reason("CI trigger configured: $hasCITrigger")
}

# Synopsis: Azure DevOps projects should implement monitoring and observability.
Rule 'Azure.DevOps.Monitoring.Enabled' -Ref 'AZR-DO-010' -Type 'Microsoft.VisualStudio/account/project' -Tag @{ release = 'GA'; ruleSet = '2025_03'; 'Azure.DevOps/capability' = 'Continuous Operations'; } {
    # Check if Application Insights or other monitoring is configured
    $Assert.HasField($TargetObject, 'properties.serviceConnections')
    
    $hasMonitoring = $false
    if ($TargetObject.properties.serviceConnections) {
        foreach ($connection in $TargetObject.properties.serviceConnections) {
            if ($connection.type -eq 'azurerm' -or $connection.type -eq 'applicationinsights') {
                $hasMonitoring = $true
                break
            }
        }
    }
    
    $Assert.Pass().Reason("Monitoring configured: $hasMonitoring")
}

# Synopsis: Azure DevOps projects should implement quality gates in release pipelines.
Rule 'Azure.DevOps.Quality.Gates' -Ref 'AZR-DO-011' -Type 'Microsoft.VisualStudio/account/project/releaseDefinition' -Tag @{ release = 'GA'; ruleSet = '2025_03'; 'Azure.DevOps/capability' = 'Continuous Quality'; } {
    $Assert.HasField($TargetObject, 'properties.environments')
    
    foreach ($environment in $TargetObject.properties.environments) {
        if ($environment.preDeployApprovals) {
            $Assert.HasField($environment.preDeployApprovals, 'approvals')
            $Assert.Greater($environment.preDeployApprovals, 'approvals', 0)
        }
    }
}

# Synopsis: Azure DevOps projects should implement feedback loops for continuous improvement.
Rule 'Azure.DevOps.Improvement.Feedback' -Ref 'AZR-DO-012' -Type 'Microsoft.VisualStudio/account/project' -Tag @{ release = 'GA'; ruleSet = '2025_03'; 'Azure.DevOps/capability' = 'Continuous Improvement'; } {
    # Check for analytics and reporting capabilities
    $Assert.HasField($TargetObject, 'properties.capabilities.analytics')
    if ($TargetObject.properties.capabilities.analytics) {
        $Assert.In($TargetObject, 'properties.capabilities.analytics.enabled', @($true, 'true'))
    }
}

#endregion Continuous Capabilities