
# SG Public
resource "aws_security_group" "demo-sg-public" {
  name        = "demo-public"
  description = "Public SG"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow web traffic http"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow web traffic https"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = "${local.env}"
  }
}