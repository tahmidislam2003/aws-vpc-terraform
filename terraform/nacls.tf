resource "aws_network_acl" "public" {
    vpc_id = aws_vpc.main.id
    subnet_ids = aws_subnet.public[*].id

    tags = {
    Name = "${var.project_name}-public-nacl"
}
}

resource "aws_network_acl_rule" "public_inbound_https" {
    network_acl_id = aws_network_acl.public.id
    rule_number = 100
    egress = false
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 443
    to_port = 443
}

resource "aws_network_acl_rule" "public_inbound_ephermal" {
    network_acl_id = aws_network_acl.public.id
    rule_number = 200
    egress = false
    protocol = "tcp"
    rule_action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 1024
    to_port = 65535
}

resource "aws_network_acl_rule" "public_outbound_all" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}