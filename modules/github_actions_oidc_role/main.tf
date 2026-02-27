locals {
  oidc_provider_host = "token.actions.githubusercontent.com"
  allowed_subject    = format("repo:%s:ref:refs/heads/main", var.github_repository)
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    sid     = "GitHubActionsOIDC"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_provider_host}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "${local.oidc_provider_host}:sub"
      values   = [local.allowed_subject]
    }
  }
}

data "aws_iam_policy_document" "terraform_iam_minimum" {
  statement {
    sid    = "AllowManageEcsTaskRoles"
    effect = "Allow"
    actions = [
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:GetRole",
      "iam:UpdateAssumeRolePolicy",
      "iam:TagRole",
      "iam:UntagRole",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:ListAttachedRolePolicies",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:GetRolePolicy",
      "iam:ListRolePolicies"
    ]
    resources = [
      "arn:aws:iam::*:role/*-ecs-execution-role",
      "arn:aws:iam::*:role/*-ecs-task-role"
    ]
  }

  statement {
    sid    = "AllowPassRoleToEcsTasksOnly"
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = [
      "arn:aws:iam::*:role/*-ecs-execution-role",
      "arn:aws:iam::*:role/*-ecs-task-role"
    ]
    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = {
    Name        = var.role_name
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "power_user_access" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_role_policy" "terraform_iam_minimum" {
  name   = "github-actions-terraform-iam-minimum"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.terraform_iam_minimum.json
}
