# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#
# Unit tests for Azure DevOps rules
#

[CmdletBinding()]
param ()

BeforeAll {
    # Setup error handling
    $ErrorActionPreference = 'Stop';
    Set-StrictMode -Version latest;

    if ($Env:SYSTEM_DEBUG -eq 'true') {
        $VerbosePreference = 'Continue';
    }

    # Setup tests paths
    $rootPath = $PWD;
    Import-Module (Join-Path -Path $rootPath -ChildPath out/modules/PSRule.Rules.Azure) -Force;
    $here = (Resolve-Path $PSScriptRoot).Path;
}

Describe 'Azure.DevOps' -Tag 'DevOps' {
    Context 'Conditions' {
        BeforeAll {
            $invokeParams = @{
                Baseline = 'Azure.DevOps.All'
                Module = 'PSRule.Rules.Azure'
                WarningAction = 'SilentlyContinue'
                ErrorAction = 'Stop'
            }
        }

        It 'Azure.DevOps.Project.TeamStructure' {
            # Valid project with team structure
            $data = @{
                type = 'Microsoft.VisualStudio/account/project'
                properties = @{
                    capabilities = @{
                        versioncontrol = @{
                            sourceControlType = 'Git'
                        }
                        processTemplate = @{
                            templateTypeId = 'adcc42ab-9882-485e-a3ed-7678f01f66bc'
                        }
                    }
                }
            }
            $result = $data | Invoke-PSRule @invokeParams -Name 'Azure.DevOps.Project.TeamStructure';
            $result | Should -Not -BeNullOrEmpty;
            $result.Outcome | Should -Be 'Pass';
        }

        It 'Azure.DevOps.Project.CollaborationEnabled' {
            # Valid project with collaboration enabled
            $data = @{
                type = 'Microsoft.VisualStudio/account/project'
                properties = @{
                    capabilities = @{
                        boards = @{
                            sourceControlType = 'Git'
                        }
                    }
                }
            }
            $result = $data | Invoke-PSRule @invokeParams -Name 'Azure.DevOps.Project.CollaborationEnabled';
            $result | Should -Not -BeNullOrEmpty;
            $result.Outcome | Should -Be 'Pass';
        }

        It 'Azure.DevOps.Pipeline.YAMLBased' {
            # Valid YAML-based pipeline
            $data = @{
                type = 'Microsoft.VisualStudio/account/project/buildDefinition'
                properties = @{
                    type = 'build'
                    yamlFilename = 'azure-pipelines.yml'
                }
            }
            $result = $data | Invoke-PSRule @invokeParams -Name 'Azure.DevOps.Pipeline.YAMLBased';
            $result | Should -Not -BeNullOrEmpty;
            $result.Outcome | Should -Be 'Pass';
        }
    }

    Context 'DevOps Baselines' {
        It 'Should include Culture pillar baseline' {
            $baseline = Get-PSRuleBaseline -Module PSRule.Rules.Azure -Name 'Azure.DevOps.Pillar.Culture';
            $baseline | Should -Not -BeNullOrEmpty;
            $baseline.Name | Should -Be 'Azure.DevOps.Pillar.Culture';
        }

        It 'Should include Continuous Integration capability baseline' {
            $baseline = Get-PSRuleBaseline -Module PSRule.Rules.Azure -Name 'Azure.DevOps.Capability.ContinuousIntegration';
            $baseline | Should -Not -BeNullOrEmpty;
            $baseline.Name | Should -Be 'Azure.DevOps.Capability.ContinuousIntegration';
        }
    }
}