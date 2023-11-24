resource "aws_security_group" "ecs_tasks_sg" {
    name              = "ecs-tasks-sg-test"
    description       = "it is what it is"

    ingress {
        protocol        = "tcp"
        from_port       = 80
        to_port         = 80
        cidr_blocks     = ["0.0.0.0/0"]
        # security_groups = [aws_security_group.lb.id]
    }

    egress {
        description     = "Allow outbound traffic"
        protocol        = "-1"
        from_port       = 0
        to_port         = 0
        cidr_blocks     = ["0.0.0.0/0"]
    }
}