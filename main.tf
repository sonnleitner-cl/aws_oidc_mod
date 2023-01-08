data "aws_caller_identity" "current" {}

resource "aws_iam_role" "this" {
  name        = var.role_name
  path        = "/"
  description = var.role_description
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Effect = "Allow"
      Principal = {
        Federated = join("", ["arn:aws:iam::${data.aws_caller_identity.current.id}:oidc-provider/", "token.actions.githubusercontent.com"])
      }
      Condition = {
        StringLike = {
          "token.actions.githubusercontent.com:sub" : "repo:${var.org_to_authorize}/${var.repo_to_authorize}:ref:refs/heads/${var.branch_to_authorize}"
        },
        StringEquals = {
          "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com"
        }
      }
    }]
    Version = "2012-10-17"
  })
}
data "tls_certificate" "example" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "this" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [
    data.tls_certificate.example.certificates[0].sha1_fingerprint
  ]
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = var.actions_for_policy
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "this" {
  name   = var.policy_name
  path   = "/"
  policy = data.aws_iam_policy_document.this.json
}
resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
