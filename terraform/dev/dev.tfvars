# Dev Vars
execution_role_arn = "arn:aws:iam::020157571320:role/elkproject-ecs-task-execution-role"
task_role_arn      = "arn:aws:iam::020157571320:role/elkproject-ecs-task-role"
environment        = "dev"
project_name       = "elkproject"
vector_splunk_hec_token = "vVVbUPkNeME00Zu6okzbN/zlqSZPGapNA4fhDwSjpNc="

# Vector-specific variables
vector_image       = "020157571320.dkr.ecr.us-east-1.amazonaws.com/vector:latest"

# Quarkus-specific variables
quarkus_image      = "020157571320.dkr.ecr.us-east-1.amazonaws.com/elkproject:latest"
