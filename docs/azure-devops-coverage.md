---
author: BernieWhite
description: Azure DevOps coverage aligned with the Well-Architected Framework pillars and capabilities.
---

# Azure DevOps Coverage

PSRule for Azure provides comprehensive coverage for Azure DevOps services aligned with the [Azure Well-Architected Framework (WAF)][1].
This page documents how Azure DevOps capabilities map to each WAF pillar and the coverage provided by PSRule for Azure.

## Framework alignment

Azure DevOps services are validated against WAF principles across all five (5) pillars:

- [Security](#security)
- [Operational Excellence](#operational-excellence)
- [Reliability](#reliability)
- [Performance Efficiency](#performance-efficiency)
- [Cost Optimization](#cost-optimization)

## Security

Azure DevOps security capabilities that align with the WAF Security pillar:

### SE:02 Secured development lifecycle

- **Azure Repos**: Source code protection with branch policies and pull request workflows
- **Azure Artifacts**: Secure package management with upstream sources and retention policies
- **Azure Pipelines**: Secure CI/CD with service connections and variable groups
- **Security Center**: Security scanning and vulnerability assessments

### SE:06 Network controls

- **Private Endpoints**: Connect Azure DevOps services privately to Azure resources
- **IP restrictions**: Control access to Azure DevOps organizations
- **Service connections**: Secure authentication to Azure resources

### SE:07 Encryption

- **Data at rest**: All Azure DevOps data is encrypted at rest
- **Data in transit**: All communications use TLS 1.2 or higher
- **Secrets management**: Secure variable groups and key vault integration

### SE:10 Monitoring and threat detection

- **Audit logs**: Comprehensive auditing of all DevOps activities
- **Usage analytics**: Monitor user access and activity patterns
- **Security alerts**: Integration with Microsoft Defender

## Operational Excellence

Azure DevOps operational capabilities that align with the WAF Operational Excellence pillar:

### OE:02 Observability

- **Azure Monitor integration**: Pipeline monitoring and alerting
- **Application Insights**: Application performance monitoring
- **Work item tracking**: Comprehensive project and issue tracking
- **Analytics and reporting**: Built-in dashboards and custom reporting

### OE:04 Tools and processes

- **Standardized pipelines**: YAML-based infrastructure as code
- **Automated testing**: Unit, integration, and security testing
- **Release management**: Multi-stage deployments with approvals
- **Code quality gates**: Automated quality checks and reviews

### OE:05 Automation design

- **CI/CD automation**: Automated build, test, and deployment pipelines
- **Infrastructure as Code**: ARM, Bicep, and Terraform support
- **Automated security scanning**: Built-in security and compliance checks
- **Self-service capabilities**: Developer self-service through standardized processes

### OE:07 Monitoring system

- **Pipeline health monitoring**: Real-time pipeline status and history
- **Service health dashboards**: Azure DevOps service status monitoring
- **Performance metrics**: Build and deployment performance tracking
- **Incident management**: Integration with incident response workflows

## Reliability

Azure DevOps reliability capabilities that align with the WAF Reliability pillar:

### RE:02 Critical flows

- **Multi-region availability**: Azure DevOps operates across multiple regions
- **Disaster recovery**: Built-in backup and recovery capabilities
- **Service continuity**: High availability architecture with redundancy
- **Critical path protection**: Branch policies protect main branches

### RE:04 Target metrics

- **SLA monitoring**: Track service level agreement compliance
- **Performance baselines**: Establish and monitor performance targets
- **Availability metrics**: Monitor service uptime and reliability
- **Quality metrics**: Track code quality and test coverage metrics

### RE:05 Redundancy

- **Geographic redundancy**: Data replicated across multiple regions
- **Service redundancy**: Multiple service instances for high availability
- **Backup strategies**: Automated backups with point-in-time recovery
- **Failover capabilities**: Automatic failover for critical services

### RE:07 Self-preservation

- **Rate limiting**: Protect services from excessive load
- **Circuit breakers**: Prevent cascade failures in dependent services
- **Resource quotas**: Manage resource consumption and prevent exhaustion
- **Health monitoring**: Continuous health checks and auto-recovery

## Performance Efficiency

Azure DevOps performance capabilities that align with the WAF Performance Efficiency pillar:

### PE:02 Capacity planning

- **Parallel processing**: Parallel job execution for faster builds
- **Agent pools**: Scalable build and deployment agents
- **Resource scaling**: Automatic scaling based on demand
- **Capacity monitoring**: Track resource utilization and plan capacity

### PE:03 Selecting services

- **Hosted agents**: Microsoft-hosted agents for different platforms
- **Self-hosted agents**: Custom agents for specific requirements
- **Container support**: Docker and Kubernetes integration
- **Cloud-native services**: Integration with Azure PaaS services

### PE:05 Scaling and partitioning

- **Horizontal scaling**: Scale out build agents based on demand
- **Partitioned workflows**: Separate pipelines for different workloads
- **Distributed builds**: Distribute build tasks across multiple agents
- **Caching strategies**: Dependency and build caching for performance

### PE:08 Data performance

- **Artifact optimization**: Efficient artifact storage and retrieval
- **Package feeds**: Optimized package management and distribution
- **Build acceleration**: Incremental builds and smart caching
- **Content delivery**: Global content distribution for faster access

## Cost Optimization

Azure DevOps cost optimization capabilities that align with the WAF Cost Optimization pillar:

### CO:02 Cost model

- **Usage-based pricing**: Pay only for what you use
- **Transparent pricing**: Clear pricing model with no hidden costs
- **Cost allocation**: Track costs by project and team
- **Resource optimization**: Optimize agent usage and parallel jobs

### CO:04 Usage optimization

- **Efficient agent usage**: Optimize build agent utilization
- **Parallel job management**: Balance performance and cost
- **Artifact retention**: Optimize storage costs with retention policies
- **Resource scheduling**: Schedule builds during off-peak hours

### CO:06 Rate optimization

- **Volume discounts**: Better rates for higher usage tiers
- **Reserved capacity**: Pre-purchase parallel jobs for discounts
- **Shared resources**: Share agents and resources across teams
- **Cost monitoring**: Track and optimize spending patterns

### CO:12 Optimize environment costs

- **Development environments**: Optimize dev/test environments
- **Resource lifecycle**: Automatically clean up temporary resources
- **Rightsizing**: Match resources to actual requirements
- **Cost governance**: Implement cost controls and budgets

## Integration with PSRule for Azure

PSRule for Azure enhances Azure DevOps workflows by providing:

### Pipeline Integration

- **Native Azure Pipelines extension**: Easy integration through marketplace extension
- **YAML pipeline support**: Infrastructure as code for pipeline definitions
- **Multi-stage validation**: Validate resources across development lifecycle
- **Quality gates**: Implement validation as quality gates between environments

### Validation Capabilities

- **Pre-deployment validation**: Validate resources before deployment
- **Compliance checking**: Ensure resources meet organizational standards
- **Security validation**: Check security configurations and best practices
- **Cost optimization**: Validate resource configurations for cost efficiency

### Reporting and Monitoring

- **Test result integration**: Publish validation results as test results
- **Dashboard integration**: Custom dashboards with validation metrics
- **Notification integration**: Alert teams of validation failures
- **Trend analysis**: Track validation results over time

## Getting Started

To start using PSRule for Azure with Azure DevOps:

1. **Install the extension**: Get the [PSRule extension][2] from the Azure DevOps marketplace
2. **Configure pipelines**: Add PSRule tasks to your YAML pipelines
3. **Set up validation**: Configure rules and baselines for your organization
4. **Monitor results**: Review validation results and implement fixes

For detailed guidance, see:

- [Creating your pipeline][3]
- [Azure Pipelines CI scenario][4]
- [Working with baselines][5]

## More Information

- [Azure DevOps Documentation][6]
- [Azure Well-Architected Framework][1]
- [PSRule for Azure Rules][7]

  [1]: https://learn.microsoft.com/azure/architecture/framework/
  [2]: https://marketplace.visualstudio.com/items?itemName=bewhite.ps-rule
  [3]: creating-your-pipeline.md
  [4]: scenarios/azure-pipelines-ci/azure-pipelines-ci.md
  [5]: working-with-baselines.md
  [6]: https://learn.microsoft.com/azure/devops/
  [7]: en/rules/index.md

*[WAF]: Well-Architected Framework
*[CI/CD]: Continuous Integration/Continuous Deployment
*[SLA]: Service Level Agreement
*[TLS]: Transport Layer Security