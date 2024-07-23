
resource "aws_ecr_repository" "repository" {
  name = "test-repo"
  image_scanning_configuration{
    scan_on_push = true
  }
}

#resource "aws_ecs_cluster" "cluster" {
#  name = "test-cluster"
#}
#
#resource "aws_iam_role" "ecsTaskExecutionRole" {
#  name               = "ecsTaskExecutionRole"
#  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
#}
#
#data "aws_iam_policy_document" "assume_role_policy" {
#  statement {
#    actions = ["sts:AssumeRole"]
#
#    principals {
#      type        = "Service"
#      identifiers = ["ecs-tasks.amazonaws.com"]
#    }
#  }
#}
#
#resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
#  role       = "${aws_iam_role.ecsTaskExecutionRole.name}"
#  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
#}
#
#resource "aws_cloudwatch_log_group" "ecs_log_group" {
#  name = "/ecs/app-first-task-log-group"
#}
#
#resource "aws_ecs_task_definition" "app_task" {
#  family                   = "app-first-task"
#  container_definitions    = jsonencode([
#    {
#      name         = "app-first-task",
#      image        = "${aws_ecr_repository.repository.repository_url}",
#      essential    = true,
#      readonlyRootFilesystem = true,
#      portMappings = [
#        {
#          containerPort = 3831,
#          hostPort      = 3831 
#        }
#      ],
#      memory        = 512,
#      cpu           = 256,
#      logConfiguration = {
#        logDriver = "awslogs",
#        options   = {
#          awslogs-group = "${aws_cloudwatch_log_group.ecs_log_group.name}",
#          awslogs-region        = "ap-southeast-2",
#          awslogs-stream-prefix = "ecs"
#        }
#      }
#    }
#  ])
#  requires_compatibilities = ["FARGATE"]
#  network_mode             = "awsvpc"
#  memory                   = 512
#  cpu                      = 256
#  execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
#}
#
#resource "aws_default_vpc" "default_vpc" {
#}
#
#resource "aws_default_subnet" "default_subnet_a" {
#  availability_zone = "ap-southeast-2a"
#}
#
#resource "aws_default_subnet" "default_subnet_b" {
#  availability_zone = "ap-southeast-2b"
#}
#
#resource "aws_security_group" "load_balancer_security_group" {
#  ingress {
#    from_port   = 80 
#    to_port     = 80
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"] 
#  }
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}
#
#resource "aws_alb" "application_load_balancer" {
#  name               = "load-balancer-dev" #load balancer name
#  load_balancer_type = "application"
#  subnets = [ # Referencing the default subnets
#    "${aws_default_subnet.default_subnet_a.id}",
#    "${aws_default_subnet.default_subnet_b.id}"
#  ]
#  # security group
#  security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
#}
#
#resource "aws_lb_target_group" "target_group" {
#  name        = "target-group"
#  port        = 80
#  protocol    = "HTTP"
#  target_type = "ip"
#  vpc_id      = "${aws_default_vpc.default_vpc.id}" # default VPC
#}
#
#resource "aws_lb_listener" "listener" {
#  load_balancer_arn = "${aws_alb.application_load_balancer.arn}" #  load balancer
#  port              = "80"
#  protocol          = "HTTP"
#  default_action {
#    type             = "forward"
#    target_group_arn = "${aws_lb_target_group.target_group.arn}" # target group
#  }
#}
#
#resource "aws_security_group" "service_security_group" {
#  ingress {
#    from_port = 0
#    to_port   = 0
#    protocol  = "-1"
#    # Only allowing traffic in from the load balancer security group
#    security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
#  }
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}
#
#resource "aws_ecs_service" "app_service" {
#  name            = "app-first-service"     # Name the service
#  cluster         = "${aws_ecs_cluster.cluster.id}"   # Reference the created Cluster
#  task_definition = "${aws_ecs_task_definition.app_task.arn}" # Reference the task that the service will spin up
#  launch_type     = "FARGATE"
#  desired_count   = 3 
#
#  load_balancer {
#    target_group_arn = "${aws_lb_target_group.target_group.arn}" # Reference the target group
#    container_name   = "${aws_ecs_task_definition.app_task.family}"
#    container_port   = 3831 # Specify the container port
#  }
#
#  network_configuration {
#    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}"]
#    assign_public_ip = false # Provide the containers with public IPs
#    security_groups  = ["${aws_security_group.service_security_group.id}"] # Set up the security group
#  }
#}
#
#output "app_url" {
#  value = aws_alb.application_load_balancer.dns_name
#}
#
