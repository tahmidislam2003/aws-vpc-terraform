resource "aws_s3_bucket" "flow_logs" {
    bucket = "${var.project_name}-flow-logs-${random_id.suffix.hex}"

    tags = {
        Name = "${var.project_name}-flow-logs"
    }
}

resource "random_id" "suffix" {
    byte_length = 3
}

resource "aws_flow_log" "main" {
    vpc_id = aws_vpc.main.id
    traffic_type = "ALL"
    log_destination_type = "s3"
    log_destination = aws_s3_bucket.flow_logs.arn

    tags = {
        Name = "${var.project_name}-flow-log"
    }
}