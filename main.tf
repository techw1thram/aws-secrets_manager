resource "aws_secretsmanager_secret" "my_secret" {
  for_each                = var.secrets
  name                    = lookup(each.value, "name_prefix", null) == null ? each.key : null
  name_prefix             = lookup(each.value, "name_prefix", null) != null ? lookup(each.value, "name_prefix") : null
  description             = lookup(each.value, "description", null)
  kms_key_id              = lookup(each.value, "kms_key_id", null)
  policy                  = lookup(each.value, "policy", null)
  tags                    = merge(var.tags, lookup(each.value, "tags", null))
}

resource "aws_secretsmanager_secret_version" "my_secret_version" {
  for_each      = { for k, v in var.secrets : k => v if !var.tf_manage }
  secret_id     = each.key
  secret_string = lookup(each.value, "secret_string", null) != null ? lookup(each.value, "secret_string", null) : (lookup(each.value, "secret_key_value", null) != null ? jsonencode(lookup(each.value, "secret_key_value", {})) : null)
  secret_binary = lookup(each.value, "secret_binary", null) != null ? base64encode(lookup(each.value, "secret_binary")) : null
  depends_on    = [aws_secretsmanager_secret.my_secret]

  lifecycle {
    ignore_changes = [
      secret_string,
      secret_binary,
    ]
  }
}




