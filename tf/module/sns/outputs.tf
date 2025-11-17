output "topic_arn" {
  value = aws_sns_topic.main.arn
}

output "topic_id" {
  value = aws_sns_topic.main.id
}

output "subscription_arn" {
  value = aws_sns_topic_subscription.main.arn
}

output "subscription_id" {
  value = aws_sns_topic_subscription.main.id
}
