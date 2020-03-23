## When enabled, prints DNS record changes rather than actually performing them
##
dryRun: false

## AWS configuration to be set via arguments/env. variables
##
aws:
  ## AWS credentials
  ##
  credentials:
    mountPath: "/.aws"
  ## AWS region
  ##
  region: "${ aws_region }"
  ## Limit possible target zones by route53 tags
  ##
  ${indent(2,yamlencode({"zoneTags": zone_tags_filters}))}

## TXT Registry Identifier
##
txtOwnerId: ${ cluster_name }

## Replica count
##
replicas: 1

## RBAC parameteres
## https://kubernetes.io/docs/reference/access-authn-authz/rbac/
##
rbac:
  create: true
  ## Service Account for pods
  ## https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
  ##
  serviceAccountName: ${ service_account_name }
  ## RBAC API version
  ##
  apiVersion: v1beta1
  ## Podsecuritypolicy
  ##
  pspEnabled: false
  ## Additional Service Account annotations
  serviceAccountAnnotations:
    eks.amazonaws.com/role-arn: ${ external_dns_iam_role_arn }

## Bitnami external-dns image version
## ref: https://hub.docker.com/r/bitnami/external-dns/tags/
##
image:
  registry: docker.io
  repository: bitnami/external-dns
  tag: 0.5.17-debian-9-r25

## K8s resources type to be observed for new DNS entries by ExternalDNS
##
sources:
- service
- ingress

## DNS provider where the DNS records will be created. Available providers are:
## - aws, azure, cloudflare, coredns, designate, digitalocoean, google, infoblox, rfc2136
##
provider: aws

## Whether to publish DNS records for ClusterIP services or not (optional)
##
publishInternalServices: false

## Adjust the interval for DNS updates
##
interval: "30s"

## Verbosity of the ExternalDNS logs. Available values are:
## - panic, debug, info, warn, error, fatal
##
logLevel: info

## Modify how DNS records are sychronized between sources and providers (options: sync, upsert-only)
##
policy: upsert-only

## Registry Type. Available types are: txt, noop
## ref: https://github.com/kubernetes-incubator/external-dns/blob/master/docs/proposal/registry.md
##
registry: "txt"

## Options for the source type "crd"
##
crd:
  ## Install and use the integrated DNSEndpoint CRD
  create: false

## Kubernetes svc configutarion
##
service:
  ## Kubernetes svc type
  ##
  type: ClusterIP
  port: 7979

## Kubernetes Security Context
## https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
##
securityContext:
  allowPrivilegeEscalation: false
  readOnlyRootFilesystem: true
  capabilities:
    drop: ["ALL"]
podSecurityContext:
  fsGroup: 1001
  runAsUser: 1001
  runAsNonRoot: true

## Configure resource requests and limits
## ref: http://kubernetes.io/docs/user-guide/compute-resources/
##
resources:
  limits:
    cpu: 50m
    memory: 50Mi
  requests:
    memory: 50Mi
    cpu: 10m

## Liveness Probe. The block is directly forwarded into the deployment, so you can use whatever livenessProbe configuration you want.
## ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/
##
livenessProbe:
  httpGet:
    path: /healthz
    port: http
  initialDelaySeconds: 10
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 2
  successThreshold: 1

## Readiness Probe. The block is directly forwarded into the deployment, so you can use whatever readinessProbe configuration you want.
## ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/
##
readinessProbe:
  httpGet:
    path: /healthz
    port: http
  initialDelaySeconds: 5
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 6
  successThreshold: 1

## Prometheus Exporter / Metrics
##
metrics:
  enabled: true
  ## Metrics exporter pod Annotation and Labels
  ##
