output "role_arn" {
  value = aws_iam_role.main.arn
}

output "role_id" {
  value = aws_iam_role.main.id
}

output "role_name" {
  value = aws_iam_role.main.name
}

output "policy_id" {
  value = aws_iam_role_policy.main.id
}

output "policy_name" {
  value = aws_iam_role_policy.main.name
}
