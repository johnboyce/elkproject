# Prod Vars
execution_role_arn = "arn:aws:iam::020157571320:role/elkproject-ecs-task-execution-role"
task_role_arn      = "arn:aws:iam::020157571320:role/elkproject-ecs-task-role"
environment        = "prod"
project_name       = "elkproject"


# Vector-specific variables
vector_image       = "020157571320.dkr.ecr.us-east-1.amazonaws.com/vector:latest"

# Quarkus-specific variables
quarkus_image      = "020157571320.dkr.ecr.us-east-1.amazonaws.com/elkproject:latest"
