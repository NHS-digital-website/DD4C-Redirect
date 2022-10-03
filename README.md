# DD4C-Redirect
The DD4C redirection service

# Set up
Begin by installing the AWS CLI `aws configure`. Set the default region to `eu-west-2`.
Then configure AWS CLI such that you can assume the `NHSDAdminRole` by adding the following dd4c profile to your local `~/.aws/config` file.

```
[profile dd4c]
role_arn = arn:aws:iam::<Account ID>:role/NHSDAdminRole
mfa_serial = arn:aws:iam::<Account ID>:mfa/<Your username>
source_profile = default
```

Then install Pip `sudo apt install python3-pip`. Then using Pip install [AWSume](https://awsu.me/) `pip3 install awsume`. 

| Note                                  |
| ------------------------------------- |
| Make sure you add AWSume to the path. |

You should now be able to do `awsume dd4c` which will prompt you for your MFA code. 

# Good to know
The Terraform state is held in an AWS S3 bucket named `dd4c-terraform-state`.