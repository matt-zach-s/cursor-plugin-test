output "endpoint" {
  description = "Redis primary endpoint"
  value       = aws_elasticache_cluster.this.cache_nodes[0].address
}

output "port" {
  description = "Redis port"
  value       = aws_elasticache_cluster.this.cache_nodes[0].port
}

output "security_group_id" {
  description = "Security group ID for the Redis cluster"
  value       = aws_security_group.this.id
}
