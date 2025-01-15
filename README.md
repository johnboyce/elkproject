# ELKProject: Quarkus Application with ECS, ALB, and ELK Stack

Push to dev, before pushing to main

## Overview

The **ELKProject** is a Quarkus-based application that is deployed on AWS ECS Fargate. The infrastructure supports scalable deployment and centralized logging using Elasticsearch, Kibana, and Vector. This document outlines the infrastructure components, configuration, deployment steps, and mitigations for issues encountered during setup.

---

## Infrastructure Overview

### **Terraform Modules**

The infrastructure is managed using Terraform with a modular structure for reusability and scalability. Key modules include:

#### **1. VPC**

- **Description**: Configures a VPC with public and private subnets.
- **Components**:
  - **Internet Gateway (IGW)** for public subnets.
  - **NAT Gateway** for private subnets to access the internet.
  - Route tables for public and private subnets.
- **Purpose**: Provides the networking backbone for the ECS service and ALB.

#### **2. S3**

- **Description**: An S3 bucket to store Terraform state.
- **Configuration**:
  - Server-side encryption using AES256.
  - Lifecycle rules for efficient state management.
- **Purpose**: Ensures centralized and secure storage of the Terraform state.

#### **3. Security Groups**

- **Description**: Security group rules to allow controlled communication.
- **Configuration**:
  - **ALB Security Group**: Allows inbound traffic on ports 80 and 443.
  - **ECS Task Security Group**: Allows traffic from the ALB and outbound internet access via the NAT Gateway.
- **Purpose**: Ensures secure communication between components.

#### **4. ALB**

- **Description**: An Application Load Balancer to handle incoming traffic.
- **Configuration**:
  - **Listeners**: HTTP (port 80).
  - **Target Group**: Configured with health checks for ECS tasks.
- **Purpose**: Routes traffic to ECS tasks based on health status.

#### **5. ECS Cluster and Service**

- **Description**: ECS Fargate service hosting the Quarkus application.
- **Configuration**:
  - ECS tasks run in private subnets.
  - Associated with the ALB target group for load balancing.
- **Purpose**: Runs the Quarkus application securely and scalably.

#### **6. ELK Stack**

- **Description**: Elasticsearch, Kibana, and Vector for centralized logging.
- **Components**:
  - **Vector**: Ships logs to Elasticsearch.
  - **Elasticsearch**: Stores logs for querying.
  - **Kibana**: Visualizes logs.

---

## Additional Steps to Mitigate Issues

### **1. Lack of Load Balancer Association**

- **Problem**: Initial ECS service configuration did not associate with the ALB.
- **Solution**:
  - Updated ECS service to include the `--load-balancers` parameter.
  - Verified target registration and health check configuration in the ALB.

### **2. Health Checks Not Attempted**

- **Problem**: ALB health checks were not being triggered.
- **Solution**:
  - Verified and corrected the health check path to `/q/health`.
  - Ensured ECS tasks were registered in the target group.
  - Fixed security group rules to allow traffic between ALB and ECS tasks.

### **3. Public Access Issues**

- **Problem**: Unable to access the application from the internet.
- **Solution**:
  - Added public subnets for the ALB with appropriate routing to the Internet Gateway.
  - Verified ALB DNS name for accessibility.

---

## Deployment Steps

### **1. Provision Infrastructure**

1. Initialize Terraform:
    terraform init

2. Plan and apply changes:
    terraform plan
    terraform apply

### **2. Build and Push Quarkus Application Image**

1. Build the native image for Quarkus:
    ./mvnw package -Pnative

2. Push the image to Amazon ECR:
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <ECR_URI>
    docker tag elkproject:latest <ECR_URI>/elkproject:latest
    docker push <ECR_URI>/elkproject:latest

### **3. Deploy to ECS**

1. Update ECS service with the new task definition and load balancer:
    aws ecs update-service \
      --cluster my-cluster \
      --service elkproject-service \
      --task-definition elkproject \
      --load-balancers targetGroupArn=arn:aws:elasticloadbalancing:us-east-1:020157571320:targetgroup/elkproject-tg/1234567890abcdef,containerName=elkproject-container,containerPort=8080 \
      --force-new-deployment

### **4. Validate Deployment**

1. Check ALB Target Group:
   - Confirm ECS tasks are healthy.

2. Access the Application:
   - Use the ALB DNS name: `http://<ALB_DNS>`.

---

## Testing and Monitoring

### **1. Logs**

- Access CloudWatch logs for ECS tasks.
- Use Kibana to view and analyze application logs.

### **2. Health Checks**

- Verify ALB health checks in the **Target Groups** section of the EC2 Console.

### **3. Application Metrics**

- Add custom monitoring using AWS CloudWatch.

---

## Future Improvements

- Implement HTTPS on the ALB using ACM for enhanced security.
- Automate deployment pipelines using GitHub Actions.
- Optimize Terraform modules for multi-environment support.

---

## Contact

For questions or issues, reach out to the project maintainers
.
