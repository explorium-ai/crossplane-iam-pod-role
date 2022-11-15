# Crossplane Iam Pod Role

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/explorium-ai/crossplane-iam-pod-role)](https://img.shields.io/github/v/release/explorium-ai/crossplane-iam-pod-role)
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/crossplane-iam-pod-role)](https://artifacthub.io/packages/search?repo=crossplane-iam-pod-role)

**crossplane-iam-pod-role** is a kubernetes chart that is an aggregation of *crossplane crd manifests with service account*. 

It allows for k8s applications to manage and create their own Aws cloud permissions. It uses [Crossplane](https://github.com/crossplane/crossplane) as its main crd manifests, an [Aws OIDC identity provider](https://aws.amazon.com/blogs/containers/introducing-oidc-identity-provider-authentication-amazon-eks/) is the natively Eks way of assuming Aws Iam roles, we combine both into 1 easy single helm chart for utilize the permissions. 

## Prerequisite of this chart

1. Please follow the [Oidc provider](https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html) docs and install it into your cluster
2. Please follow the [Crossplane](https://artifacthub.io/packages/helm/crossplane/crossplane) docs and install it into your cluster.
   once installed, make sure to add Iam full permissions to your ProviderConfig.
## Install using Helm chart

- Configure the below values
    ```yaml

    # -- # Defines the role name prefix.
    # -- # Part of the iam role/policy name that will be created
    role_name_prefix: "crossplane-eks-"

    # -- # Defines the pod name that will assume the permissions.
    # -- # Part of the iam role/policy name that will be created
    pod_name: "my-pod-name"

    # -- # Defines the cluster name that we are using.
    # -- # Part of the iam role/policy name that will be created
    cluster_name: "my-cluster-name"

    # -- # Defines the service account that will be created
    service_account:
      create: true
    # -- # Defines the imagePullSecrets atributes for the service account. (not required)  
      imagePullSecrets: 
        - name: my-secret

    # --  Defines if service account and other resources will have the annotation:
    # --  "helm.sh/hook: pre-install" and will be create first in any combination with other charts
    pre_install_annotations: true

    # -- # Aws configurations
    
    # -- # Aws account id for the Iam role trust relationship policy
    aws_account_id: "1234567890"
    # -- # Aws Eks openId connect id for the Iam role trust relationship policy
    aws_eks_openId_connect_number: "1111111111222222222GGGGGGGGGPPPPPPPPPP"
    # -- # Aws region for the Iam role trust relationship policy
    aws_region: eu-west-1

    # -- # Defines the Iam policies that will be created and attached to the Iam role
    policies:
        policydocument1:
            {
                "Id": "crossplane-eks-policydocument1",
                "Version": "2012-10-17",
                "Statement": [
                    {
                        "Action": [
                            "iam:CreateServiceLinkedRole"
                        ],
                        "Condition": {
                            "StringEquals": {
                                "iam:AWSServiceName": [
                                    "elasticloadbalancing.amazonaws.com"
                                ]
                            }
                        },
                        "Effect": "Allow",
                        "Resource": "*",
                        "Sid": ""
                    }
                ]
            }
        policydocument2:
            {
                "Id": "crossplane-eks-policydocument2",
                "Version": "2012-10-17",
                "Statement": [
                    {
                        "Action": [
                            "iam:CreateServiceLinkedRole"
                        ],
                        "Condition": {
                            "StringEquals": {
                                "iam:AWSServiceName": [
                                    "elasticloadbalancing.amazonaws.com"
                                ]
                            }
                        },
                        "Effect": "Allow",
                        "Resource": "*",
                        "Sid": ""
                    }
                ]
            }
    # -- # Defines the name of the crossplane provider-config,
    # -- # which should be predefined with Iam full access
    # -- # for more info, look at aws-provider docs below
    provider_config_name: aws-provider
    # -- # Iam role and policies Aws tags
    tags:
        Component: k8s
        Environment: dev
        ManageBy: crossplane-my-cluster
        Name: crossplane-k8s-my-pod
        Team: RND
        Type: Platform
    ```

    [aws-provider docs](https://github.com/crossplane/crossplane/blob/master/docs/cloud-providers/aws/aws-provider.md)

- Install latest version of crossplane-iam-pod-role helm chart

    ```
    $ helm repo add crossplane-iam-pod-role https://explorium-ai.github.io/crossplane-iam-pod-role/
    $ helm repo update
    $ helm install crossplane-iam-pod-role/crossplane-iam-pod-role -f values.yaml
    ```
## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on the process for submitting pull requests.

## Code of Conduct

Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for details on our code of conduct, and how to report violations.

## License

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details
