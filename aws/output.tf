output "ecr_repository" {
  description = "Elastic Container Registry"
  value       = {
    url = aws_ecr_repository.ecr_repository.repository_url
    arn = aws_ecr_repository.ecr_repository.arn
  }
}

output "ecs_task" {
  description = "Elastic Container Service"
  value       = aws_ecs_task_definition.ecs_task
}