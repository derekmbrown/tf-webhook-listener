resource "aws_iam_role" "main" {
  name = "${var.project}-${var.env}"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Sid": "",
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "${var.service}"
      }
    }]
  })
}

resource "aws_iam_role_policy" "main" {
  name = "${var.project}-${var.env}"
  role   = aws_iam_role.main.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Action": "apigateway:*",
      "Resource": "*"
    }, {
      "Effect": "Allow",
      "Action": "logs:*",
      "Resource": "*"
    }, {
      "Effect": "Allow",
      "Action": "dynamodb:*",
      "Resource": "*"
    }, {
      "Effect": "Allow",
      "Action": "ec2:*",
      "Resource": "*"
    }, {
      "Effect": "Allow",
      "Action": "sns:*",
      "Resource": "*"
    }, {
      "Effect": "Allow",
      "Action": "lambda:*",
      "Resource": "*"
    }]
  })
}