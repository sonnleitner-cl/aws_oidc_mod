role_name        = "tf_role_basic"
role_description = "oidc role for auth github"
policy_name      = "tf_basic"
actions_for_policy = [
  "s3:*",
  "iam:*",
  "dynamodb:*",
  "route53:*",
  "cloudfront:*",
  "ecs:*",
  "ec2:*",
  "eks:*"
]
org_to_authorize    = "sonnleitner-cl"
repo_to_authorize   = "aws_oidc"
branch_to_authorize = "main"
