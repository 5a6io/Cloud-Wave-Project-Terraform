resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.project_name}-cache-subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_replication_group" "this" {
  replication_group_id       = "${var.project_name}-redis"
  description                = "Redis for ${var.project_name}"
  engine                     = "redis"
  engine_version             = var.engine_version
  node_type                  = var.node_type
  num_cache_clusters         = 1
  automatic_failover_enabled = false
  parameter_group_name       = "default.redis7"
  subnet_group_name          = aws_elasticache_subnet_group.this.name
  security_group_ids         = var.security_group_ids

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-redis"
  })
}
