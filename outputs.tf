output "secret_ids" {
  description = "Secret ids map"
  value       = { for k, v in aws_secretsmanager_secret.my_secret : k => v["id"] }
}

output "secret_arns" {
  description = "Secrets arns map"
  value       = { for k, v in aws_secretsmanager_secret.my_secret : k => v["arn"] }
}


